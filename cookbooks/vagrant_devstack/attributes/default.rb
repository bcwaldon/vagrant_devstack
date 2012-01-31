
default[:apt][:distro] = "maverick"
default[:apt][:proxy_url] = nil
default[:apt][:sources] = {
  :anso => {
    :url => "http://packages.ansolabs.com/",
    :keyserver => "pgp.mit.edu",
    :keys => [
      "40976EAF437D05B5",
      "6A4F7797460DF9BE",
    ],
  }
}
