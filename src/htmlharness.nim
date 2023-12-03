import nimquery, std/[htmlparser, strutils]
import xmltree except text
export xmltree except text
export nimquery

type Harness*[selector: static string] = XmlNode

proc first*[S](T: typedesc[Harness[S]], html: string): Harness[S] =
  return html.parseHtml().querySelector(S)

proc first*[S](T: typedesc[Harness[S]], root: XmlNode): Harness[S] =
  return root.querySelector(S)

proc all*[S](T: typedesc[Harness[S]], html: string): seq[Harness[S]] =
  return html.parseHtml().querySelectorAll(S)

proc all*[S](T: typedesc[Harness[S]], root: XmlNode): seq[Harness[S]] =
  return root.querySelectorAll(S)


proc text*[S](harness: Harness[S]): string =
  harness.innerText.strip

proc fromText*[S](T: typedesc[Harness[S]], root: XmlNode, text: string): Harness[S] =
  let els = T.all(root)
  for el in els:
    if el.text == text: return el
  raise newException(ValueError, "Element matching " & "'" & S & "'" & " not found with text " & "'" & text & "'")