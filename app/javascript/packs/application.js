// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();

  const input = document.querySelector('input');
  const asso_list = document.querySelector(`.asso_list`)

  if (input) { //si je suis sur la search page
  input.addEventListener('keyup', (event) => {
    console.log(input.value);
    const asso_api = `https://entreprise.data.gouv.fr/api/rna/v1/full_text/${input.value}?per_page=30`;
    fetch(asso_api)
      .then((response) => response.json())
      .then((data) => {
        asso_list.innerHTML = null;
        data.association.forEach(asso => {
          const list = `<div class="card"><li>
          <h1>${asso.titre}</h1>
          <p>${asso.objet}</p>
          </li>
          </div>`;
          asso_list.insertAdjacentHTML("beforeend", list);
        });
      });
})
  }
});

