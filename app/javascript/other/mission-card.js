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
        const insertDiv = `<div class="card asso-card" id="toggle"><h1>${missionAssociationData.name}</h1><p>${missionAssociationData.description}</p><h2>${missionAssociationData.address} <br> ${missionAssociationData.zipcode}</h2><br><h5>${missionAssociationData.city}</h5></div>`

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
