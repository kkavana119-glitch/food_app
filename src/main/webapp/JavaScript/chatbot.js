const chatBox = document.getElementById("chatBox");
const messageInput = document.getElementById("message");
const typing = document.getElementById("typing");

// Enter key support
messageInput.addEventListener("keypress", function(e){

    if(e.key==="Enter"){
        sendMessage();
    }

});

function sendMessage(){

    let message = messageInput.value.trim();

    if(message===""){
        return;
    }

    // User Message

    chatBox.innerHTML += `
        <div class="message user">
            <div class="bubble">
                ${message}
            </div>
        </div>
    `;

    messageInput.value="";
    messageInput.focus();

    chatBox.scrollTo({
        top:chatBox.scrollHeight,
        behavior:"smooth"
    });

    typing.style.display="block";

    fetch("chat",{

        method:"POST",

        headers:{
            "Content-Type":"application/x-www-form-urlencoded"
        },

        body:"message="+encodeURIComponent(message)

    })

    .then(response=>response.text())

    .then(reply=>{

        typing.style.display="none";

        chatBox.innerHTML += `
            <div class="message bot">
                <div class="bubble">
                    ${reply.replace(/\n/g,"<br>")}
                </div>
            </div>
        `;

        chatBox.scrollTo({
            top:chatBox.scrollHeight,
            behavior:"smooth"
        });

    })

    .catch(error=>{

        typing.style.display="none";

        chatBox.innerHTML += `
            <div class="message bot">
                <div class="bubble">
                    ❌ Unable to connect to FoodieExpress AI.
                </div>
            </div>
        `;

        chatBox.scrollTo({
            top:chatBox.scrollHeight,
            behavior:"smooth"
        });

        console.error(error);

    });

}

// Open / Close Chat

function toggleChat(){

    const chat=document.getElementById("chatWindow");

    if(chat.style.display==="block"){

        chat.style.display="none";

    }else{

        chat.style.display="block";

    }

}

function closeChat(){

    document.getElementById("chatWindow").style.display="none";

}

function minimizeChat(){

    document.getElementById("chatWindow").style.display="none";

}