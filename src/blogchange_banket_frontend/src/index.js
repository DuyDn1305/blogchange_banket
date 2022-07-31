import { blogchange_banket_backend } from "../../declarations/blogchange_banket_backend";

// document.querySelector("form").addEventListener("submit", async (e) => {
//   e.preventDefault();
//   const button = e.target.querySelector("button");

//   const name = document.getElementById("name").value.toString();

//   button.setAttribute("disabled", true);


//   (async () => {
//     try {
//       const publicKey = await window.ic.plug.requestConnect();
//       console.log(`The connected user's public key is:`, publicKey);
//       const greeting = await blogchange_banket_backend.greet(window.ic.plug.principalId);
    
//       button.removeAttribute("disabled");
    
//       document.getElementById("greeting").innerText = greeting;
//     } catch (e) {
//       console.log(e);
//     }
//   })();

//   return false;
// });

document.getElementById("connectBtn").addEventListener("click", (e) => {
  (async () => {
    try {
      const publicKey = await window.ic.plug.requestConnect();
      console.log(`The connected user's public key is:`, window.ic.plug.principalId);
      // const greeting = await blogchange_banket_backend.greet(window.ic.plug.principalId);
      // button.removeAttribute("disabled");
    
      document.getElementById("showPID").value  = "Hello: " +  window.ic.plug.principalId;

      const data = await blogchange_banket_backend.test_trie();

console.log(data)
    } catch (e) {
      console.log(e);
    }
  })();
})
// function createElementFromString (str) {
//   const element = new DOMParser().parseFromString(str, 'text/html');
//   const child = element.documentElement.querySelector('body').firstChild;
//   return child;
// };


// document.getElementById("myTable").append()

// createAccount ( FirstName : Text, LastName : Text, Birthday : Text, Phone : Text, Address: Text, Sex : Bool ) 