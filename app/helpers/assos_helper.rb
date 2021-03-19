module AssosHelper
  def image_svg(asso)
    case asso.category
    when "animaux"
      image_tag('animaux.svg', class: "svg_img")
    when "art"
      image_tag('art.svg', class: "svg_img")
    when "politique"
      image_tag('politique.svg', class: "svg_img")
    when "alimentation"
      image_tag('alimentation.svg', class: "svg_img")
    when "culture"
      image_tag('culture.svg', class: "svg_img")
    when "education"
      image_tag('education.svg', class: "svg_img")
    when "environnement"
      image_tag('environnement.svg', class: "svg_img")
    when "santé"
      image_tag('sante.svg', class: "svg_img")
    when "social"
      image_tag('social.svg', class: "svg_img")
    when "sport"
      image_tag('sport.svg', class: "svg_img")
    else
      image_tag('default_image.svg', class: "svg_img")
    end
  end
end
