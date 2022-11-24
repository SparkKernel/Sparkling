const callback = async (name, data) => {
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
    $('.cancel').click(() => {
        callback('cancel', {}).then((data) => {
            console.log("TRUE, FALSE: "+data)
            $('.prompt').hide()
        })
    })

    $('.submit').click(() => {
        callback('submit', {
            text: $('.input').val()
        }).then((data) => {
            $('.input').val('')
            $('.prompt').hide()
        })
    })
})

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.show) {
        if (item.object != "menu") {
            $('.'+item.object).show();
            $('.header').text(item.text)
        } else {
            $('.'+item.object).css({
                'display': 'flex'
            })
            $('.header2').text(item.text)
        }
        console.log(JSON.stringify(item))
        if (item.list) {
            $('.buttons').empty()
            var currentIndex = item.list.length
            item.list.forEach(element => {
                currentIndex -= 1
                $('<div id="'+new String(currentIndex)+'" class="button">'+element+'</div>').appendTo('.buttons');
            });
        }
    } else {
        if (item.object != "menu") {
            $('.'+item.object).show();
        } else {
            $('.'+item.object).css({
                'display': 'none'
            })
        }
    }
});