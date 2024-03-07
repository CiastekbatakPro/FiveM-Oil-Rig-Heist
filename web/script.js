let globalupaljen = 0
let upaljen = 0

window.addEventListener('message', (event) => {
	let data = event.data
    if (data.message == "showUI") { 
        let x = document.querySelector("#container")
        x.style.display = "block";
    }
})

document.addEventListener('keyup', (e) => {
    if (e.code == "Escape") { 
        let x = document.querySelector("#container")
        x.style.display = "none";
        $.post('http://rigHeist/closeMenu', JSON.stringify({}));
    }
});

CloseUI = function() { 
    let x = document.querySelector("#container")
    x.style.display = "none";
    $.post('http://rigHeist/closeMenu', JSON.stringify({}));
}

StartMission = function() { 
    CloseUI()
    $.post('http://rigHeist/startJob', JSON.stringify({}));
}