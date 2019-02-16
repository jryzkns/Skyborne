project = Template

default:
	love ../$(project)

clean:
	rm -rf ~/.local/share/love/$(project)/

show:
	ls ~/.local/share/love/$(project)/