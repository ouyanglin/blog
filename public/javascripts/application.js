// Take visitor to sign in page if they hit the ESC key

function whichKey(event) {
  var keynum = event.which;
  if (keynum == 27) {
    window.location.assign("/signin")
  }
}
