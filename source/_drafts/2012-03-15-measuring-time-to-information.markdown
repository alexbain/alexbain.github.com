---
layout: post
title: "TTI: Measuring Time to Information"
date: 2012-03-15 22:50
comments: true
categories: tti
published: false
---

## Measuring your Time to Information


## Improving your Time to Information

Now that TTI is defined, I've outlined what aspects of TTI I have control over, and I've outlined what aspects I don't have control over. So since at least some aspects of TTI is within my control, how can I isolate those aspects and improving them? This is a work in progress, but here's what I've got so far.

### Improving your TTI: self control

This is a hard one. Improving your self control is not an easy task. There is a lot of literature surrounding self control, willpower, & habits. If you're interested it's definitely worth seeking out. Here's are some tips I've found that have helped me improve my self control when it comes to searching for information:

* **Define a clear goal** - It's easy to get distracted by peripheral information. You may be able to deem some information irrelevant faster when you have a clearly defined goal.
* **Give yourself a way to offload thoughts** - When you're on the hunt for a piece of information you'll stumble across information that's interesting but not directly related to your goal. If you don't want to abandon this information (perhaps because it's valuable to the domain but not your specific goal) try keeping a scratch pad open and jot down links and notes. This keeps your mind from getting cluttered with information not directly relevant to my goal. Also, close unused tabs. 
* **Constrain the problem** - When a query returns far too much information to effectively parse (most do) it's best to constrain the problem and try again. Try adding additional search terms, re-evaluating whether the terms you used are the most applicable, etc.

### Improving your TTI: tool selection

Tool selection can ultimately provide drastic reductions (improvements) to your TTI. While a service like Google provides exceptional access to a breadth of content when you're interested in exploring a specific domain sometimes a different tool can be better suited to the task. A concrete example would be using [StackOverflow][1] to answer programming questions, [Yelp][2] to find business information, [Wikipedia][2] for reputable information about any sort of topic, or [WolframAlpha][3] for any kind of numerical computation. If you start with a specialized tool for your query you're likely to increase your chances of finding that information quickly and efficiently.

So, to start, consider the queries you make most frequently. Do you look up recipes often? Search for code snippets? Search through academic papers? Fact check articles you're reading? If you frequently use the same tool for these tasks it's likely a good candidate to focus on makking more efficient.

In addition, consider spending time learning to use these tools as efficiently as possible. Do they have an app you can use on your phone? Do you use them frequently enough to bookmark them or add them to your bookmark toolbar? Can you add their search functionality as a search option in your web browser? Can you use keyboard shortcuts to navigate through the tool faster than by using a mouse? If you use a service like [Alfred][4] or [QuickSilver][5] does it make sense to add shortcuts there, as well? All of these minor efficiency improvements can lead to noticeable reductions in TTI, especially when it comes to keeping yourself in the context of the problem at hand

### Improving your TTI: Information parsing

Over the years I've spent a lot of time both building and using web applications. As it turns out, about 40-60% of the content a given page presents is completely irrelevant to the task at hand. Titlebars, sidebars, footers, and advertisements are likely to contain zero information of value when you're viewing an information details page. If you can train yourself to quickly locate where the 'real' content lives on a given web application you can zero in on that section without having to worry about whether there is important information in useless sections.

## Conclusion

We're reached a point in human evolution where the question is no longer "does the information exist" or "where can I find the information" but has now become "how quickly can I find the information on the internet"? By leveraging the boundless information on the web we now have the capability of functioning as super intelligent beings, limited only by the speed with which we can access the information. 

By becoming aware of the time we spend searching for information we can take steps to get at our information faster. The benefit of a reduced time to information is less time weeding through data or browsing awful interfaces and more time spent solving problems. I can only hope that designers and developers begin focusing on this metric as a metric for success in usability studies in the months and years to come.


====


Finding information on the internet. It should be easy, right? If I type a question into Google I'm presented with millions of results. Blam. More information than I could ever read.

But wait. Which of these millions of results actually answer my question?

Just because I've found millions of potential results doesn't mean anything about the relevance or the quality. Or, more importantly, whether any of those results actually answers my exact question or solves my specific problem. While the time to run a query and find millions of potential results may take less than a quarter of a second the time required to sift through the information and find my answer can be much more time consuming.

Before discussing this problem, however, let's add some context and define some terms. Start by asking yourself two questions:

* How many times have I sat down at my computer to answer a (seemingly) simple question?
* How many times was I able to answer that question without getting distracted or sucked into a vortex of information?

For me, this is becoming a more and more common experience. For example, I'm diving into the world of Arduino projects and sat down at my desk the other night to purchase the components necessary to build a project idea. I had a reasonable idea of what I needed and assumed it would be a fifteen minute task to search, find the parts, and purchase them. Not quite. Once I sat down and got into researching the available options I quickly became lost in a sea of information.

I found accounts of people attempting similar projects, software solutions that abstract away some of the data acquisition and parsing, sites selling individual parts (with poor or missing descriptions), and countless other pieces of information relevant to my quest for knowledge. This wealth of information turned a fifteen minute task into a two hour research endeavor. Two hours later I ended up purchasing $6 of parts, bookmarked a few resources to reference while building the project, and called it a success.

Why, did it take me two hours? Was I not working efficiently? Did I underestimate the amount of information I'd have to sort through? Was I just being optimistic in how much time it would take me to solve this? Is the information for this specific question distributed amongst many resources?

Real questions, with no real answer. You could flippantly respond that this is just how the internet is and you'll have to accept it. I think that's the wrong approach. Twenty years ago it was impossible to fathom what Google Instant Search can do for parsing data. Twenty years from now I fully expect to be able to ask any question and get a precise answer in a quarter second. How do you measure the time that takes, though? Do you measure the time from when the user sits down at their computer until the time they stand up again? From the time they initially visit a search engine until they go back to another tab? These are some of the things I'm trying to figure out.

I think there are a few components to "Time to Information," as a concept.

1: Self control / will power (did you get distracted)?
2: Tools (Are you using the right tools? Are they configured in such a way to help you work quickly? Are you using the tools to their ultimate potential?)?
3: Information parsing Your ability to sift and rate information you find (is this high quality information? Can I trust this source?)

### Self Control / Will Power

This, as far as I can tell, is the first hurdle to overcome to reducing your personal time to information index. If you're setting out on an information gathering quest you need to be able to keep yourself on track.

You must be able to stay focused when presented with all the distractions of the computer. Did you just get an email? What happened on Twitter? Was that your phone that just buzzed? Has anyone said something cool on Facebook since you last checked? What did my friend just send me over GTalk? I wonder what's new on Reddit...

Fighting all of these urges and staying on track can be difficult. I've developed a few tricks that help me focus in this regard:

* Clearly define my goal.
* Open up a text file to write out notes or peripheral thoughts or ideas to. This gets them out of my head (where they bounce around and distract me) without having to commit to answering them.
* Define a time period for information gathering.
* Close out all programs that could distract me.
* Go into full screen mode to prevent anything from distracting me.
* Put yourself in a physical place that's free of distractions (if possible, otherwise perhaps put on some non distracting music)

If you go through these steps it's just going to be you and the task at hand.

### Tools

This is the second hurdle to overcome. A generic tool, like Google, will get you far but for domain specific information Google may not be the best tool. Consider, for example, a swiss army knife.

[[PICTURE OF A SWISS ARMY KNIFE]]

This tool will help you out in a pinch. You could even imagine that 90% of your day to day tasks will be covered by the swiss army knife. Now, however, imagine I asked you to cut through a steak. Not a hard problem, definitely solvable with the blade on the knife, but it sure would be easier with a steak knife. Or what if you needed to cut down a tree? A swiss army knife, perhaps, could solve the job but you'd be spending a lot of wasted time making it fit the job. For that you'd probably enjoy a chain saw.

[[PICTURE OF A CHAIN SAW]]

To help expedite domain specific queries I've found it extremely useful to have an array of search engines to pick from. Having an arsenal of tools at your disposal allows you to quickly select the correct search engine based on the problem at hand.

For example, the site [Stack Overflow][1] is a fantastic resource for programming questions and answers. If I have a question related to programming I'm most likely to find the answer there. If I start my search on Google it might surface the most relevant content but, realistically, it's not the best way to answer my question.

If I'm trying to find a physical place I'll frequently turn to [Yelp][2]. This is an obvious one for many in the Bay Area but it's everything the Yellow Pages once was but so, so much more. If I, instead, turned to Google I may get lucky with Google Places but if it's not familiar with the name it might just pull up irrelevant search results.

If there's a question to be asked where you'd like some domain experts to chime in you may find [Quora][3] to be right up your alley. I've had very good luck sourcing information from them.

Want to book a hotel near you tonight? Good luck answering that question on Google. Between spam results, scams, and location irrelevant information you're not likely to find what you're looking for. However, if you used [[WHATEVER THAT STARTUP IS]] you'll be on your way in minutes.

And the list goes on. Between forums, search engines, friends, Q&A sites, and apps you're likely to find that someone has sliced up information in such a way where you can get your information quickly.

So that's tools. Spend the time to build an arsenal of tools and spend a few seconds thinking about which tool to use before just diving in to Google. You'll probably end up saving yourself a lot of time in the long run.

### Information Parsing

The third and final piece to the puzzle is your ability to rapidly scan information and parse what you're looking for. 

To start, I've been doing a lot of reading and thinking about self control, will power, habits, and productivity. There is a growing body of research (including some very solid books) that discuss the neurological basis of these psychological traits.

Now that we're knee deep into the age of information it's become clear that the amount of information available at your fingertips far exceeds what anyone is capable of absorbing. When you factor in the wild quality variability of the information you quickly reach a saturation point in a few respects:

* Too many sources of information
* Unknown (or perhaps falsely believed) quality of information
* Emotional coloration of information based on opinions or beliefs you may not
  hold or agree with.

Combining this with the endless distractions on the internet (as well as the pretend urgency that the internet seems to be saturated with) it becomes extremely hard to stay focused, get the information you need, and disengage.

So how do you stay focused? How do you close the loop between what you intend to do on the internet and what you actually end up accomplishing?

