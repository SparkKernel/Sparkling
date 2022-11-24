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
        btn.css({"background-color":'#faebd7'})

        document.getElementById(new String(item.index)).scrollIntoView()

        if (item.method == 'up') {
            $('.menu .buttons #'+new String(item.index-1)).css({'background-color': '#234449'})
        } else {
            $('.menu .buttons #'+new String(item.index+1)).css({'background-color': '#234449'})
        }
    }
});