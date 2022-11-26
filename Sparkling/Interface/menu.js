const callback2 = async (name, data) => {
    const d = await fetch(`https://${GetParentResourceName()}/${name}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data)
    })
    return d.json()
}

$(document).ready(() => {
})

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.index) {
        $('.menu').show()
        item.index -= 1
        const btn = $('.menu .buttons #'+new String(item.index))
        console.log(btn.text())
        btn.css({"background-color":'#6c6862'})

        document.getElementById(new String(item.index)).scrollIntoView()

        const next = $('.menu .buttons #'+new String(item.index-1))
        const down = $('.menu .buttons #'+new String(item.index+1))

        const cssData = {'background-color': '#222730'}

        if (item.method == 'up') {
            next.css(cssData)
        } else if (item.method == 'down') {
            down.css(cssData)
        } else if (item.method == 'teleport') {
            $('.menu .buttons #'+new String(item.oldIndex-1)).css(cssData)
        }
    }
});