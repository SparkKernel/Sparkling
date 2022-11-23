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
            $('.OurDiv').hide()
        })
    })

    $('.submit').click(() => {
        callback('submit', {
            text: $('.input').val()
        }).then((data) => {
            $('.input').val('')
            $('.OurDiv').hide()
        })
    })
})

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.show) {
        $('.OurDiv').show();
        $('.header').text(item.text)
    } else {
        $('.OurDiv').hide();
    }
});