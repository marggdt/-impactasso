const initCards = () => {
  document.querySelectorAll('.asso-card').forEach((card) => {
    card.addEventListener('mouseover', ev => {
      updateMarkerSelected(ev.currentTarget.dataset.assoId)
    })
  })
};

export { initCards };