# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def toggle_displays(displays)
    "javascript:"+displays.collect { |display| "toggle_display('#{display}')"}.join(";")
  end

end
