module CitiesHelper
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
