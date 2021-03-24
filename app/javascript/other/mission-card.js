const initMissionCardHover = () => {
  // vérifier que je suis sur la bonne page (missionindex)
  const index = document.querySelector('#mission-cards');
  if (index) {
    const cards = document.querySelectorAll('.mission-card')

    cards.forEach((card) => {
      card.addEventListener("mouseenter", (event) => {
        const toRemoveDiv = document.getElementById('toggle')
        const placeholderImage = document.querySelector('#placeholder')
        if (placeholderImage) {

          placeholderImage.classList.add('hidden')
        }
        if (toRemoveDiv) {
          toRemoveDiv.remove()

        }
        const missionId = card.id.match(/mission-(.*)/)[1]
        const cardJson = document.getElementById(`mission${missionId}-data`)
        const missionAssociationData = JSON.parse(cardJson.textContent)
        console.log(missionAssociationData)
        const display = document.querySelector('.displayasso')
        const insertDiv = `<div class="card asso-card" id="toggle"><h1>${missionAssociationData.name}</h1><div class="svg_img"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" version="1.1" width="512" height="512" x="0" y="0" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512" xml:space="preserve" class=""><g><g xmlns="http://www.w3.org/2000/svg">	<g>		<path d="M506.555,208.064L263.859,30.367c-4.68-3.426-11.038-3.426-15.716,0L5.445,208.064    c-5.928,4.341-7.216,12.665-2.875,18.593s12.666,7.214,18.593,2.875L256,57.588l234.837,171.943c2.368,1.735,5.12,2.57,7.848,2.57    c4.096,0,8.138-1.885,10.744-5.445C513.771,220.729,512.483,212.405,506.555,208.064z" fill="#2ac489" data-original="#000000" style=""/>	</g></g><g xmlns="http://www.w3.org/2000/svg">	<g>		<path d="M442.246,232.543c-7.346,0-13.303,5.956-13.303,13.303v211.749H322.521V342.009c0-36.68-29.842-66.52-66.52-66.52    s-66.52,29.842-66.52,66.52v115.587H83.058V245.847c0-7.347-5.957-13.303-13.303-13.303s-13.303,5.956-13.303,13.303v225.053    c0,7.347,5.957,13.303,13.303,13.303h133.029c6.996,0,12.721-5.405,13.251-12.267c0.032-0.311,0.052-0.651,0.052-1.036v-128.89    c0-22.009,17.905-39.914,39.914-39.914s39.914,17.906,39.914,39.914v128.89c0,0.383,0.02,0.717,0.052,1.024    c0.524,6.867,6.251,12.279,13.251,12.279h133.029c7.347,0,13.303-5.956,13.303-13.303V245.847    C455.549,238.499,449.593,232.543,442.246,232.543z" fill="#2ac489" data-original="#000000" style=""/>	</g></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g><g xmlns="http://www.w3.org/2000/svg"></g></g></svg></div><p>${missionAssociationData.description}</p><h2>${missionAssociationData.address} <br> ${missionAssociationData.zipcode}</h2><br><h5>${missionAssociationData.city}</h5></div>`

        display.insertAdjacentHTML('beforeend',insertDiv);

      })
    })
    cards.forEach((card) => {
      card.addEventListener("mouseleave", (event) => {
        const toRemoveDiv = document.getElementById('toggle')
        const placeholderImage = document.querySelector('#placeholder')
        if (toRemoveDiv) {
          toRemoveDiv.remove()
        }
        if (placeholderImage) {
          placeholderImage.classList.remove('hidden')
        }
      })
    })

  }

}
  export { initMissionCardHover }
