
google.load("feeds", "1");

function initialize() {
    var newsFeed = $("#newsFeed");
    var feed = new google.feeds.Feed(newsFeed.data("url"));
    feed.setNumEntries(5);
    feed.load(function (result) {
        if (!result.error) {
            newsFeed.html("");
            for (var i = 0; i < result.feed.entries.length; i++) {
                var entry = result.feed.entries[i];
                var published = new Date(entry.publishedDate);
                var mediaContainer = $(document.createElement('div'));
                var mediaIconLink = $(document.createElement("a"));
                var mediaIcon = $(document.createElement("img"));
                var mediaBody = $(document.createElement("div"));
                var mediaHeader = $(document.createElement("h4"));

                mediaContainer.addClass("media");
                mediaIconLink.addClass("pull-left media-object");
                mediaBody.addClass("media-body");
                mediaHeader.addClass("media-heading");

                mediaIconLink.attr("href", entry.link);
                mediaIcon.attr("src", getContextPath() + "/assets/images/icons/rss.png");

                mediaHeader.html(entry.title + " <small> - " + published.format("mmm dd, yyyy") + "</small>");
                mediaBody.html(entry.contentSnippet);

                mediaIcon.appendTo(mediaIconLink);
                mediaIconLink.appendTo(mediaContainer);
                mediaBody.appendTo(mediaContainer);
                mediaHeader.prependTo(mediaBody);
                mediaContainer.appendTo(newsFeed);
            }
        }
        else {
            newsFeed.text("Error (" + result.error.code + "): " + result.error.message);
        }
    });
}
google.setOnLoadCallback(initialize);