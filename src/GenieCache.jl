"""
Caching functionality for Genie.
"""
module GenieCache

import SHA, Logging
import Genie

export cachekey, withcache, @cache
export purge, purgeall


const CACHE_DURATION = Ref{Int}(0)
const CACHE_PATH = Ref{String}("cache")


"""
    cache_duration()

Returns the default duration of the cache in seconds.
"""
function cache_duration()
  CACHE_DURATION[]
end


"""
    cache_duration!(duration::Int)

Sets the default duration of the cache in seconds.
"""
function cache_duration!(duration::Int)
  CACHE_DURATION[] = duration
end


"""
    cache_path()

Returns the default path of the cache folder.
"""
function cache_path()
  CACHE_PATH[]
end


"""
    cache_path!(cachepath::AbstractString)

Sets the default path of the cache folder.
"""
function cache_path!(cachepath::AbstractString)
  CACHE_PATH[] = cachepath
end


"""
    withcache(f::Function, key::Union{String,Symbol}, expiration::Int = GenieCache.cache_duration(); dir = "", condition::Bool = true)

Executes the function `f` and stores the result into the cache for the duration (in seconds) of `expiration`. Next time the function is invoked,
if the cache has not expired, the cached result is returned skipping the function execution.
The optional `dir` param is used to designate the folder where the cache will be stored (within the configured cache folder).
If `condition` is `false` caching will be skipped.
"""
function withcache end


"""
    purge()

Removes the cache data stored under the `key` key.
"""
function purge end


"""
    purgeall()

Removes all cached data.
"""
function purgeall end


macro cache(expr)
  quote
    withcache($(esc(string(expr)))) do
      $(esc(expr))
    end
  end
end


### PRIVATE ###


"""
    cachekey(args...) :: String

Computes a unique cache key based on `args`. Used to generate unique `key`s for storing data in cache.
"""
function cachekey(args...) :: String
  key = IOBuffer()
  for a in args
    print(key, string(a))
  end

  bytes2hex(SHA.sha1(String(take!(key))))
end

end
