# Lab 1 - *TumblrFeed*

**TumblrFeed** is a photo browsing app using the [The Tumblr API](https://www.tumblr.com/docs/en/api/v2#posts).

Time spent: **3** hours spent in total

## User Stories

The following **required** user stories are complete:

- [x] User can scroll through a feed of images returned from the Tumblr API (5pts)

The following **stretch** user stories are implemented:

- [x] User sees an alert when there's a networking error (+1pt)
- [x] While poster is being fetched, user see's a placeholder image (+1pt)
- [ ] User sees image transition for images coming from network, not when it is loaded from cache (+1pt)
- [ ] Customize the selection effect of the cell (+1pt)

The following **additional** user stories are implemented:

List anything else that you can get done to improve the app functionality! (+1-3pts)

- [x] Pull down refresh to reload the feed

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. add an option to change rows to display more than one picture per row
2. tap on a picture to see more information (comments, etc.)

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/motiveg/TumblrFeed/raw/master/TumblrFeedDemo1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The main challenge I encountered was an error setting the cell image with the url. I found out that for some reason my Image View outlet wasn't connected to my PhotoCell class, but it took me a while to discover as I was looking at other possible errors in my code.

## License

Copyright [2018] [Brian Casipit]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

----

# Lab 2 - *Name of App Here*

**Name of your app** is a photo browsing app app using the [The Tumblr API](https://www.tumblr.com/docs/en/api/v2#posts).

Time spent: **10** hours spent in total

## User Stories

The following **required** user stories are complete:

- [x] User can tab an image to view a larger image in a detail view (5pts)

The following **stretch** user stories are implemented:

- [ ] Add Avatar and Publish Dates (+2pt)
- [ ] Zoomable Photo View (+2pt)
- [ ] Infinite Scrolling (+2pt)

The following **additional** user stories are implemented:

- [ ] List anything else that you can get done to improve the app functionality! (+1-3pts)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. add summary in the PhotosDetailsViewController or part of summary in the PhotosViewController
2. settings menu to display/hide headers in PhotosViewController

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/motiveg/TumblrFeed/raw/master/TumblrFeedDemo2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I had a difficult time understanding what photo/image information I was supposed to pass to the PhotoDetailsViewController. I initially assumed I had to pass the actual photo; I accidentally skipped over a sentence in one of the previous steps which said to pass the photo URL. But because of this, I was able to spend time trying to understand the process of getting/setting up an index path and how to access things in collections.

## License

    Copyright [2018] [Brian Casipit]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
