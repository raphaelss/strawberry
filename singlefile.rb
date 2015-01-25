#!/usr/bin/env ruby

$html_in = 'densidade.html'
$js_in = 'densidade.js'
$html_out = 'strawberry.html'

$jquery = 'ext/jquery.min.js'
$bootstrap_css = 'ext/bootstrap.min.css'
$bootstrap_js = 'ext/bootstrap.min.js'

$js_line = "    <script src=\"densidade.js\"></script>\n"
$jquery_line = "    <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js\"></script>\n"
$bootstrap_css_line = "    <link href=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css\" rel=\"stylesheet\">\n"
$bootstrap_js_line = "    <script src=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js\"></script>\n"

def write_js(file, out)
  out.write('<script type="text/javascript">')
  File.open(file) do |fin|
    fin.each { |line| out.write(line) }
  end
  out.write('</script>')
end

def write_css(file, out)
  out.write('<style type="text/css">')
  File.open(file) do |fin|
    fin.each { |line| out.write(line) }
  end
  out.write('</style>')
end

File.open($html_out, "w") do |out|
  File.open($html_in) do |html|
    html.each do |line|
      case line
      when $js_line
        write_js($js_in, out)
      when $jquery_line
        write_js($jquery, out)
      when $bootstrap_css_line
        write_css($bootstrap_css, out)
      when $bootstrap_js_line
        write_js($bootstrap_js, out)
      else
        out.write(line)
      end
    end
  end
end
