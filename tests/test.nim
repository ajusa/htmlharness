import htmlharness

type BodyHarness = Harness["body"]
type CardHarness = Harness[".card"]
type ButtonHarness = Harness["button"]

const sampleHtml = """
<!DOCTYPE html>
<html>
  <head><title>Example</title></head>
  <body>
    <div class="card" aria-label="hello there!">
      <h1>My heading</h1>
      <p>My body</p>
      <button>First button</button>
      <button hx-get="/asdf">Second button</button>
    </div>
  </body>
</html>
"""
let harness = BodyHarness.first(sampleHtml)
let cardHarness = CardHarness.first(harness)

doAssert cardHarness.querySelector("p").innerText == "My body"
doAssert ButtonHarness.first(cardHarness).text == "First button"
doAssert ButtonHarness.all(cardHarness).len == 2

doAssert ButtonHarness.fromText(cardHarness, "Second button").attr("hx-get") == "/asdf"
doAssertRaises(ValueError): 
  discard ButtonHarness.fromText(cardHarness, "Not a real button")