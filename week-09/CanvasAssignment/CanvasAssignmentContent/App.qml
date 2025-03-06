import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: mainWindow
    width: 800
    height: 800
    color: "lavender"

    // Lista kaikkien pallojen säilyttämiseen
    property var balls: []

    // Canvas pallojen piirtämiseen
    Canvas {
        id: canvas
        anchors.fill: parent
        property real lastX: 0
        property real lastY: 0

        // Kaikkien pallojen piirto canvasille
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            for (var i = 0; i < balls.length; i++) {
                var ball = balls[i];
                ctx.fillStyle = ball.color;
                ctx.beginPath();
                ctx.arc(ball.x, ball.y, ball.radius, 0, Math.PI * 2, false);
                ctx.fill();
            }
        }

        // Uuden pallon luonti näyttöä klikatessa
        MouseArea {
            anchors.fill: parent
            onClicked: {
                createBall(mouseX, mouseY);
            }
        }
    }

    Timer {
        id: animationTimer
        interval: 16
        running: true
        repeat: true
        onTriggered: {
            updateBalls();
            canvas.requestPaint();
        }
    }

    // Uuden pallon luominen
    function createBall(x, y) {
        // Satunnainen väri
        var r = Math.floor(Math.random() * 256);
        var g = Math.floor(Math.random() * 256);
        var b = Math.floor(Math.random() * 256);
        var color = "rgb(" + r + "," + g + "," + b + ")";

        // Satunnainen suunta
        var vx = (Math.random() * 10 - 5);
        var vy = (Math.random() * 10 - 5);

        // Varmistetaan että pallolla on vähimmäisnopeus
        if (Math.abs(vx) < 1) vx = vx < 0 ? -1 : 1;
        if (Math.abs(vy) < 1) vy = vy < 0 ? -1 : 1;

        // Pallo -objektin luonti
        var ball = {
            x: x,
            y: y,
            radius: 20,
            color: color,
            vx: vx,
            vy: vy
        };

        // Lisätään luotu pallo taulukkoon
        balls.push(ball);
    }

    // Funktio kaikkien pallojen päivittämiseen
    function updateBalls() {
        for (var i = 0; i < balls.length; i++) {
            var ball = balls[i];

            // Sijaintien päivitys
            ball.x += ball.vx;
            ball.y += ball.vy;

            // Törmäystilanteen käsittely
            if (ball.x - ball.radius < 0) {
                ball.x = ball.radius;
                ball.vx = -ball.vx;
                // Satunnainen uusi suunta x:lle
                ball.vx = Math.random() * 5 + 1;
            } else if (ball.x + ball.radius > canvas.width) {
                ball.x = canvas.width - ball.radius;
                ball.vx = -ball.vx;
                ball.vx = -(Math.random() * 5 + 1);
            }

            if (ball.y - ball.radius < 0) {
                ball.y = ball.radius;
                ball.vy = -ball.vy;
                // Satunnainen uusi suunta y:lle
                ball.vy = Math.random() * 5 + 1;
            } else if (ball.y + ball.radius > canvas.height) {
                ball.y = canvas.height - ball.radius;
                ball.vy = -ball.vy;
                ball.vy = -(Math.random() * 5 + 1);
            }
        }
    }
}
