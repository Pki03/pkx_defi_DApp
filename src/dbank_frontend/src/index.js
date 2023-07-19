//regards to angela who taught it
//first create the dfx in ubuntu then navigate to ic projects in vsc then you can start by npm install then dfx start dfx deploy npm start

import { dbank_backend } from "../../declarations/dbank_backend";
//when we refresh then update function is called
window.addEventListener("load", async function() {
  // console.log("Finished loading");
  update();
});

document.querySelector("form").addEventListener("submit", async function(event) {
  event.preventDefault();
  // console.log("Submitted.");

  const button = event.target.querySelector("#submit-btn");
//parse float is also used because we have already in mo file se it to float
  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true);

  if (document.getElementById("input-amount").value.length != 0) {
    await dbank_backend.topUp(inputAmount);
  }

  if (document.getElementById("withdrawal-amount").value.length != 0) {
    await dbank_backend.withdraw(outputAmount);
  }

  await dbank_backend.compound();

  update();


  //this code is used to empty out the input field when user has submitted
  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";

  button.removeAttribute("disabled");

});

async function update() {
  const currentAmount = await dbank_backend.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
};
