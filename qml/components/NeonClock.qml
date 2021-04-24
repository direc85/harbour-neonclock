import QtQuick 2.0

Canvas {
    id: clockCanvas
    anchors.centerIn: parent
    property bool coverMode: false
    property real drawUnit: width / (coverMode ? 32 : 50)
    readonly property bool canPaint: coverMode || Qt.application.active
    property bool drawPendulum: true
    property bool drawSeconds: true

    property var now

    property int ms
    property int s
    property int m
    property int h

    property real s_f
    property real m_f
    property real h_f

    property real secondAngle
    property real minuteAngle
    property real hourAngle

    renderStrategy: Canvas.Threaded
    renderTarget: Canvas.FramebufferObject
    onPaint: {
        if (!canPaint) return

        now = new Date()
        ms = now.getMilliseconds()
        s = now.getSeconds()
        m = now.getMinutes()
        h = now.getHours()
        var ctx = getContext("2d")


        // "Smooth" times.
        // e.g. 1min 15sec --> 1.25min
        s_f = s +  ms / 1000.0
        m_f = m + s_f / 60.0
        h_f = h + m_f / 60.0

        // Origin to the center, 0 degrees is up
        ctx.setTransform(1, 0, 0, 1, width/2, width/2)
        ctx.rotate(-Math.PI/2)
        ctx.clearRect(-width/2,-width/2,width,width)

        secondAngle = s_f / 60.0 * Math.PI*2
        minuteAngle = m_f / 60.0 * Math.PI*2
        hourAngle = (h_f % 12.0) / 12.0 * Math.PI*2

        ctx.fillStyle = 'rgba(0,0,0,0)'
        ctx.lineCap = 'round'

        if(!coverMode) {
            if(drawPendulum) {
                // Pendulum dot
                var pendulumSwing = s_f / 60.0 * Math.PI * 30
                var pendulumAngle = Math.sin(pendulumSwing) * Math.PI/6 + Math.PI/2
                ctx.rotate(pendulumAngle);
                ctx.beginPath()
                ctx.strokeStyle = 'rgb(255, 255, 255)'
                ctx.lineWidth = drawUnit * 1.5;
                ctx.moveTo(0, drawUnit * 5 - 0.01)
                ctx.lineTo(0, drawUnit * 5 + 0.01)
                ctx.stroke()
                ctx.rotate(-pendulumAngle)
            }

            if(drawSeconds) {
                // Seconds arc
                ctx.beginPath()
                ctx.strokeStyle = 'rgb(255, 100, 150)'
                ctx.lineWidth = drawUnit;
                ctx.moveTo(drawUnit * 19,0)
                ctx.arc(0, 0, drawUnit * 19, 0, secondAngle, m % 2 == 1)
                ctx.stroke()
            }

            // Minutes arc
            ctx.beginPath()
            ctx.strokeStyle = 'rgb(150, 100, 255)'
            ctx.lineWidth = drawUnit;
            ctx.moveTo(drawUnit * 21,0)

            ctx.arc(0, 0, drawUnit * 21, 0, minuteAngle, h % 2 == 1)
            ctx.stroke()

            // Hours arc
            ctx.beginPath()
            ctx.strokeStyle = 'rgb(150, 255, 100)'

            ctx.moveTo(drawUnit * 23, 0)
            ctx.arc(0, 0, drawUnit * 23, 0, hourAngle, h>=12)
            ctx.stroke()
        }

        // Hours hand
        ctx.rotate(hourAngle);
        ctx.beginPath()
        ctx.strokeStyle = 'rgb(150, 255, 100)'
        ctx.lineWidth = drawUnit * 1.5;
        ctx.moveTo(0, 0)
        ctx.lineTo(drawUnit * 9, 0);
        ctx.stroke()

        // Minutes hand
        ctx.rotate(minuteAngle-hourAngle);
        ctx.beginPath()
        ctx.strokeStyle = 'rgb(150, 100, 255)'
        ctx.lineWidth = drawUnit * 1.2;
        ctx.moveTo(0, 0)
        ctx.lineTo(drawUnit * 12, 0);
        ctx.stroke()

        if(drawSeconds)
        {
            // Seconds hand
            ctx.rotate(secondAngle-minuteAngle);
            ctx.beginPath()
            ctx.strokeStyle = 'rgb(255, 100, 150)'
            ctx.lineWidth = drawUnit;
            ctx.moveTo(0, 0)
            ctx.lineTo(drawUnit * 15, 0);
            ctx.stroke()
        }

        // Center dot
        ctx.beginPath()
        ctx.strokeStyle = 'rgb(255, 255, 255)'
        ctx.lineWidth = drawUnit * 2
        ctx.moveTo(0, -0.01)
        ctx.lineTo(0, 0.01)
        ctx.stroke()
    }
}
