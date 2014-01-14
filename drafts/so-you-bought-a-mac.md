# For the aspiring Mac Geek

This guide is geared towards new Mac users who are science academics. It is an opinionated run through what I find useful and recommend for others.

## Application launchers

You want one of these. They make it fast to open any program or frequently accessed folder or file. You will type Command-Space start typing what you want and hit return after one or two letters. The built-in Spotlight (that little magnifying glass in the top right) serves a similar purpose. Importantly, however, these application launchers learn. So, for example, if when you type "c" you tend to open Google Chrome, it learns to open Chrome and not Calculator.

I use [Launchbar] and used to use [Quicksilver]. For someone starting out now and not already used to one of these, I recommend [Alfred]. For basic application launching, the free version is just fine. If you want to tap into the *many* other things you can do with these applications, you can buy the Alfred Power Pack.

## Password management
Get a password manager. [1Password] is incredible and well worth the money. It helps you create unique and safe passwords for different sites and stores them for future use, all protected by one master password that you remember. You can then fill passwords with a mouse press or keyboard shortcut. You can also store sensitive information in it and fill in credit card details. There are some free alternatives if you look around, but if you're on a Mac, 1Password can't be beat. I've been using 1Password for 5 years and have over 300 passwords saved. I can't imagine trying to store these in my head. I don't know anyone who has regretted getting 1Password.

## File syncing
I imagine this one is obvious these days, but get [Dropbox].

## Web browsing
[Chrome][] or [Safari][]:
your two best browser options. Both fast. Both based on [WebKit]. Safari has better integration with OS X. I go back and forth and can't decide. There's also [Firefox], but compared to these two it is a tad clunky and slow these days.

## Email
[Mail]
The built-in mail program is very good. Use it to supplement Gmail for offline email and to keep a backup. You might even prefer it to web-based email.

Personally, I'm using [MailMate](http://freron.com) these days, which is extremely powerful and under active development.

## Note taking
[Notational Velocity]
Where I write almost all my plain text notes. Set it up to sync via Dropbox files.

[Evernote]
An everything bucket for your notes, images, PDFs, etc. Will sync with iPhones and iPads.

[OmniOutliner Pro]
The best outlining software there is, if you are looking for such a thing.

## Bibliographic management
[Papers2]
The darling of academic PDF management. For PDF management it is unparalleled (and I use it only for that). As a reference manager to write with, it's quickly developing but only there for the most mainstream uses at this point. Similar in this regard to Mendeley.

[Mendeley]
Quickly becoming a viable alternative to Endnote. Whether it suits you will depend on your specific needs. The PDF viewer doesn't use the native OS X version, which is a deal breaker for me. The native viewer renders more quickly and more clearly. Also, the ability to assign a journal abbreviation list isn't built in yet and not all reference styles are available as .cls CHECK files yet.

[Endnote]
Terrible interface, but it gets everything you could possibly need with academic referencing done.

[BibDesk]
The best BibTeX manager I've found. Operates on a raw .bib file. I use a combination of Papers2 (for all my papers) and BibDesk (for papers I'm citing), but that's because I write in LaTeX or Markdown. If you're writing in a word processor, there's no need for BibDesk.

## LaTeX editing
[TeXShop]
A wonderfully simple LaTeX editor. It does one thing well.

## Writing
[Pages]
Wonderful word processor, but not 100% compatible with people using MS Word, and not fully capable when it comes to writing equations or cross-referencing. As a result, you'll probably find it frustrating to use for writing academic papers.

[MS Word]
Still the standard, unfortunately.

[Byword] or [iA Writer]
My two favourite distraction-free text editors. They let you focus on writing and nothing else. Byword is slightly more configurable than iA Writer. That isn't always a good thing. These kinds of editors are largely intended for your first draft.

## Presentations and graphic editing
[Lightroom]
I use it for 99% of my photo editing. Perhaps the best application made by Adobe. Hard to believe it comes from the same company who makes Flash and Adobe Acrobat.

[Pixelmator]
An inexpensive, small, and fast application that mimics a light version of Photoshop in a more intuitive interface.

[Inkscape]
Essentially an open-source version of Illustrator. The interface leaves a bit to be desired (because it's written with an X11 interface to be cross-platform), but it gets the job done. Useful for editing vector figures from R or creating vector illustrations.

[Keynote]
Keynote from iWork is vastly superior to Powerpoint in usability and output quality. It's available from the App Store for not much money.

## PDF viewers
[Skim] and [Preview]
Both good PDF readers. I use both. Skim has auto-refreshing of changed files, which prevents insanity when dealing with LaTeX or R. Preview refreshes, but only when you change away and back to the application. Preview has the advantage of using the standard PDF annotation format, as used by Adobe products.

## Other
[Soulver]
Soulver is a cross between a spreadsheet, a notebook, and an R interface. I use it a lot.

[GraphClick]
The best extract-data-from-graphs application I've found for any operating system.

[VLC]
Play (almost) any kind of video.

[CyberDuck] or [Interarchy] or [Transmit]
File transfer programs. CyberDuck is free. I'd use it unless you do a lot of file transferring to servers. Then look at Transmit or Interarchy.

## Text editing
You need a good text editor that you're familiar with. Which one is a matter of personal opinion and holy-internet wars have been waged on the topic. I've used them all and still use many. When I really need to get stuff done, I use MacVim. But, I wouldn't recommend it for most people. If you like coding R in RStudio, and don't need a text editor often, then I'd try TextWrangler. It's free, well established, and very good.

[Sublime Text 2]
The new and popular kid on the PC, OS X, and Linux block.

[BBedit]
The old and wise man on the OS X block.

[TextWrangler]
The free version of BBedit. For many people, TextWrangler will do all that you need and more.

[MacVim]
An OS X optimized version of Vim. Once you're reached a certain level of competence, it's as close as you'll get to wiring your brain into your text editor. Not for the faint of heart. Learn it if you want a challenge, otherwise look at a more modern alternative.

[AquaMacs]
An OS X optimized version of Emacs. Again, I wouldn't go here unless you like a challenge.

[TextMate]
Was the king of Mac text editors for a while and pioneered many concepts that are standard in other editors now. Development has been uncertain for a while now. Right now I'd have a hard time recommending it, but that might change again.

[RStudio]
A great R IDE (integrated development environment).

## Backup
[CrashPlan] or [Backblaze]
These are online backup services for around $5 or less a month. You set them up and forget about them. Well worth it for the piece of mind that offsite backups bring. You'll still probably want a local backup, because restoring from one of these services will take time.

[Time Machine]
For local backups onto an external drive. Built into the operating system. Set it up and forget about it. Iterative backups without any thought. Create a partition that is 1.5 to 2 times your hard drive size since Time Machine will just expand until it fills a partition. I use [SuperDuper!] ADD LINK as well, but for most people Time Machine will be enough.

## Little applications and preference panes that make the world go around
[JumpCut]
A clipboard manager that keeps the last 30 things you've copied in memory. You can cycle through them with shift-command-v and then the up and the arrow keys. You'll wonder how you ever lived without a clipboard manager. I now use the one built into [LaunchBar], but JumpCut is great.

[Fantastical]
A great menu-bar interface to your calendar. Lets you add items by typing natural language phrases.

[Caffeine]
Keep your screen from dimming or sleeping during presentations. Simple and effective and pretty much a must have when hooking your laptop up to a projector.

[Moom]
I've also used [SizeUp] in the past. I now have custom shortcuts in Moom to mimick all of SizeUp's features.

[Flux]
A little program that synchronizes the colour balance of your monitor to match the time of day. I.e., this program makes your display "set" when the sun sets. This makes working at night so much nicer that I can't bring myself to get rid of it. Make sure you get your location right or it won't make sense at all!


## Not essential, but make my life easier:
[TypeIt4Me] or [TextExpander]
These applications expand abbreviations as you type. They can save you a lot of typing if you get used to them. Among many other uses, I use TypeIt4Me to add email signatures.

[Screenfloat]
This one's hard to appreciate until you try it. It lets you quickly take a screenshot of anything on your screen and leave it floating on top. Great for making quick before-after comparisons or for referencing versions of plots from R.

[Isolator]
Dims out all but the front-most application.

[Bartender]
Moves menu bar items into a submenu.

[xScope]
Measure elements on the screen. I use it for working out graphing details and webdesign.

[Secrets]
Let's you tweak aspects of the OS X UI like making the silly looking 3D dock 2D.

[The Unarchiver]
An uncompression utility that handles more formats than the built in utility. Seamlessly integrates into the Finder so you don't realize it's there.

[ImageOptim]
Finds the smallest size an image can be optimized to in a given format.

[ShrinkIt]  ADD LINK
Removes any bloated file structure from a PDF. Can dramatically reduce PDF file size.

[Reeder]
My favourite RSS reader. [NetNewsWire] is also good. ADD LINK

[Omnifocus] or [Things] or [The Hit List] or [TaskPaper]
Task managers or fancy todo lists. You could also just use a text file (which is basically what TaskPaper is). If you need more complexity look at The Hit List or Things. If you need more complexity again, or subscribe to the [GTD] ADD LINK (Get Things Done) philosophy, try Omnifocus. There's a learning curve to Omnifocus, but if you need it, it's well worth learning.


[1Password]: https://agilebits.com/onepassword
[Alfred]: http://www.alfredapp.com/
[AquaMacs]: http://aquamacs.org/
[Backblaze]: http://www.backblaze.com/
[BBedit]: http://www.barebones.com/thedeck
[Bartender]: http://www.macbartender.com/
[BibDesk]: http://bibdesk.sourceforge.net/
[Caffeine]: http://lightheadsw.com/caffeine/
[Chrome]: http://www.google.com/chrome
[CrashPlan]: http://www.crashplan.com/
[CyberDuck]: http://cyberduck.ch/
[Endnote]: http://www.endnote.com/
[Evernote]: http://www.evernote.com/
[Fantastical]: http://flexibits.com/
[Firefox]: http://www.mozilla.org/en-US/firefox/new/
[Flux]: http://stereopsis.com/flux/
[GraphClick]: http://www.arizona-software.ch/graphclick/
[ImageOptim]: http://imageoptim.com/
[Inkscape]: http://inkscape.org/
[Interarchy]: http://nolobe.com/interarchy/
[Isolator]: http://willmore.eu/software/isolator/
[JumpCut]: http://jumpcut.sourceforge.net/
[Keynote]: http://www.apple.com/iwork/keynote/
[Launchbar]: http://obdev.at/launchbar/
[Lightroom]: http://www.adobe.com/products/photoshop-lightroom.html
[MacVim]: http://code.google.com/p/macvim/
[Mail]: http://http://www.apple.com/support/mail/
[Mendeley]: http://www.mendeley.com/
[Moom]: http://manytricks.com/moom/
[Notational Velocity]: http://notational.net/
[OmniOutliner Pro]: http://www.omnigroup.com/products/omnioutliner/
[Omnifocus]: http://www.omnigroup.com/products/omnifocus/
[Papers2]: http://www.mekentosj.com/papers/
[Pixelmator]: http://www.pixelmator.com/
[Preview]: http://support.apple.com/kb/HT2506
[Quicksilver]: http://qsapp.com/
[Reeder]: http://reederapp.com
[RStudio]: http://rstudio.org/
[Safari]: http://www.apple.com/safari/
[Screenfloat]: http://www.screenfloatapp.com/
[Secrets]: http://secrets.blacktree.com/
[Skim]: http://skim-app.sourceforge.net/
[SizeUp]: http://www.irradiatedsoftware.com/sizeup/
[Soulver]: http://www.acqualia.com/soulver/
[Sublime Text 2]: http://www.sublimetext.com/2
[TaskPaper]: http://www.hogbaysoftware.com/products/taskpaper
[TeXShop]: http://pages.uoregon.edu/koch/texshop/
[TextExpander]: http://smilesoftware.com/TextExpander/
[TextWrangler]: http://www.barebones.com/products/TextWrangler/
[TextMate]: http://macromates.com/
[Time Machine]: http://http://support.apple.com/kb/HT1427
[The Hit List]: http://www.potionfactory.com/thehitlist/
[The Unarchiver]: http://wakaba.c3.cx/s/apps/unarchiver.html
[Things]: http://culturedcode.com/things/
[Transmit]: http://panic.com/transmit/
[TypeIt4Me]: http://www.ettoresoftware.com/products/typeit4me/
[VLC]: http://www.videolan.org/vlc/index.html
[WebKit]: http://www.webkit.org/
[xScope]: http://iconfactory.com/software/xscope
