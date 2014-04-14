# Chitter

Chitter is an exercise in creating a service that allows users to sign up and post short messages to a public feed.

Any resemblance to any existing service is entirely coincidental, I'm sure

You can find a version of this app online [here](http://safe-beyond-8311.herokuapp.com/).

## How it works

On visiting the homepage for the first time, you can see the public feed of all 'peeps', with the most recent first. If you click on the date of an individual peep, you can see that peep in more detail, along with the other peeps in that conversation:  any direct replies are listed below the peep (if those replies have replies, a link to view more is provided instead); and if the peep you're viewing is itself a reply, the peep it is a reply to appears above.

If you want to join in the fun yourself, you can sign up (or sign in if you're a returning user) via the menu at the top of the page. From there, you can post a new peep to the public feed. Or, if there's a conversation you want to be part of, you can select an individual peep and fill in the newly visible reply form. 

## What makes it work

Chitter is a modular Sinatra application. It uses DataMapper for interactions with the database (provided by Postgres both locally and on Heroku) and BCrypt for authentication. Styling is done through LESS (compiled locally). Play with it [here](http://safe-beyond-8311.herokuapp.com/) if you fancy.