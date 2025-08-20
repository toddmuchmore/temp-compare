import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fahrenheit", "celsius"]

  convertFromFahrenheit() {
    const fahrenheit = parseFloat(this.fahrenheitTarget.value)
    if (!isNaN(fahrenheit)) {
      const celsius = (fahrenheit - 32) * 5/9
      this.celsiusTarget.value = celsius.toFixed(1)
    } else {
      this.celsiusTarget.value = ""
    }
  }

  convertFromCelsius() {
    const celsius = parseFloat(this.celsiusTarget.value)
    if (!isNaN(celsius)) {
      const fahrenheit = celsius * 9/5 + 32
      this.fahrenheitTarget.value = fahrenheit.toFixed(1)
    } else {
      this.fahrenheitTarget.value = ""
    }
  }
}