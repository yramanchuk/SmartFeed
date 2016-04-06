function getRssLinks(rssKey, atomKey) {
	var links = document.getElementsByTagName('link')
	var result = {};
    
    result[atomKey] = [];
    result[rssKey] = [];
	for (var i = 0; i < links.length; i++) {
		var rel = links[i].rel;
		if (rel == "alternate") {
            var type = links[i].type;
			if (type == "application/rss+xml") {
				result[rssKey].push(links[i].href)
			} else if (type == "application/atom+xml") {
				result[atomKey].push(links[i].href)
			}
		}
	}

	return result;
}