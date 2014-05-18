#NUFORC API

A collection of UFO sightings reorted to the [NUFORC](http://nuforc.org) website. API serves JSON and can be queried in a couple different ways.

Base URL: ```nuforc-api.jfproject.me/api/v1/```

###Location

For location queries you specify that you are searching by location then you provide the two letter state abbreviation. You can also provide a city within that state to look up.

State:

```nuforc-api.jfproject.me/api/v1/location/NY```

Returns all sightings reported from New York.

City:

```nuforc-api.jfproject.me/api/v1/location/NY/Rochester```

Returns all sightings in Rochester, NY.

###Date

You can also discover reported UFO sightings based on year, year and month, or a specific date. You use the same base URL but instead prepend the parameters with ```date```.

Year:

```nuforc-api.jfproject.me/api/v1/date/2013```

Returns all sightings from 2013.

Month:

```nuforc-api.jfproject.me/api/v1/date/2013/05```

Returns all sightings from May of 2013.

Day:

```nuforc-api.jfproject.me/api/v1/date/2013/05/07```

Returns all sightings from May 7th, 2013.

You can also get the most recent reported sightings from the current month by using:

```nuforc-api.jfproject.me/api/v1/latest```
