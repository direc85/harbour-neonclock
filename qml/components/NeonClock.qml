import QtQuick 2.0

Canvas {
    id: clockCanvas
    anchors.centerIn: parent
    property bool coverMode: false
    property real drawUnit: width / (coverMode ? 32 : 50)
    onPaint: {
        var ctx = getContext("2d")

        var now = new Date()
        var ms = now.getMilliseconds()
        var s = now.getSeconds()
        var m = now.getMinutes()
        var h = now.getHours()

        // "Smooth" times.
        // e.g. 1min 15sec --> 1.25min
        var s_f = s +  ms / 1000.0
        var m_f = m + s_f / 60.0
        var h_f = h + m_f / 60.0

        // Origin to the center, 0 degrees is up
        ctx.setTransform(1,0,0,1,width/2,width/2)
        ctx.rotate(-Math.PI/2)

        // Clear!
        //ctx.fillStyle = 'black'
        //ctx.fillRect(-width/2,-width/2,width,width)
        ctx.clearRect(-width/2,-width/2,width,width)

        var secondAngle = s_f / 60.0 * Math.PI*2
        var minuteAngle = m_f / 60.0 * Math.PI*2
        var hourAngle = (h_f % 12.0) / 12.0 * Math.PI*2

        ctx.fillStyle = 'rgba(0,0,0,0)'
        ctx.lineCap = 'round'

        if(!coverMode) {
            // Seconds arc
            ctx.beginPath()
            ctx.strokeStyle = 'rgb(255, 100, 150)'
            ctx.lineWidth = drawUnit;
            ctx.moveTo(drawUnit*19,0)
            ctx.arc(0, 0, drawUnit*19, 0, secondAngle, m % 2 == 1)
            ctx.stroke()

            // Minutes arc
            ctx.beginPath()
            ctx.strokeStyle = 'rgb(150, 100, 255)'
            ctx.moveTo(drawUnit*21,0)

            ctx.arc(0, 0, drawUnit*21, 0, minuteAngle, h % 2 == 1)
            ctx.stroke()
            ctx.closePath()

            // Hours arc
            ctx.beginPath()
            ctx.strokeStyle = 'rgb(150, 255, 100)'

            ctx.moveTo(drawUnit*23, 0)
            ctx.arc(0, 0, drawUnit*23, 0, hourAngle, h>=12)
            ctx.stroke()
            ctx.closePath()
        }

        // Hours hand
        ctx.rotate(hourAngle);
        ctx.beginPath()
        ctx.strokeStyle = 'rgb(150, 255, 100)'
        ctx.lineWidth = drawUnit*1.5;
        ctx.moveTo(0,0)
        ctx.lineTo(drawUnit*9, 0);
        ctx.stroke()
        ctx.closePath()

        // Minutes hand
        ctx.rotate(minuteAngle-hourAngle);
        ctx.beginPath()
        ctx.strokeStyle = 'rgb(150, 100, 255)'
        ctx.lineWidth = drawUnit*1.2;
        ctx.moveTo(0,0)
        ctx.lineTo(drawUnit*12, 0);
        ctx.stroke()
        ctx.closePath()

        // Seconds hand
        ctx.rotate(secondAngle-minuteAngle);
        ctx.beginPath()
        ctx.strokeStyle = 'rgb(255, 100, 150)'
        ctx.lineWidth = drawUnit;
        ctx.moveTo(0,0)
        ctx.lineTo(drawUnit*15, 0);
        ctx.stroke()
        ctx.closePath()

        // Pendulum point and center dot
        var pendulumSwing = s_f / 60.0 * Math.PI * 30
        var pendulumAngle = Math.sin(pendulumSwing) * Math.PI/6 + Math.PI/2
        ctx.rotate(pendulumAngle-secondAngle);
        ctx.beginPath()
        ctx.strokeStyle = 'rgb(255, 255, 255)'
        if(!coverMode) {
            ctx.lineWidth = drawUnit;
            ctx.moveTo(0, drawUnit*5-0.01)
            ctx.lineTo(0, drawUnit*5+0.01)
            ctx.stroke()
        }
        ctx.lineWidth = drawUnit*2
        ctx.moveTo(0, -0.01)
        ctx.lineTo(0, 0.01)
        ctx.stroke()
        ctx.closePath()
    }
}