module CitiesHelper
  # The API hands back a whole number whenever the reading lands on one, so a
  # row of plaques would otherwise mix "31" with "22.9". The figure is the
  # loudest thing on the plaque, so it always carries one decimal.
  def degrees(value)
    format("%.1f", value)
  end

  # The plaque's enamel colour is the reading, so the wall can be scanned by
  # colour before any figure is read.
  def enamel_for(celsius)
    case celsius
    when ...0    then "frost"
    when 0...12  then "sea"
    when 12...22 then "sun"
    when 22...30 then "ember"
    else "signal"
    end
  end
end
