function getRssLinks(rssKey, atomKey) {
	var links = document.getElementsByTagName('link')
	var result = {};
    
    result[atomKey] = [];
    result[rssKey] = [];
	for (var i = 0; i < links.length; i++) {
		var type = links[i].type;
		var rel = links[i].rel;
		if (rel == "alternate") {
			if (type == "application/rss+xml") {
				result[rssKey].push(links[i].href)
			} else if (type == "application/atom+xml") {
				result[atomKey].push(inks[i].href)
			}
		}
	}

	return result;
}