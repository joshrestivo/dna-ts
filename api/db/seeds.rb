# keep

50.times do

  creatures  = ['clam', 'conch', 'coral', 'crab', 'eel', 'fish', 'narwhal', 'orca', 'otter', 'puffer', 'ray', 'seahorse', 'seal', 'shark', 'shrimp', 'squid', 'turtle', 'urchin', 'walrus', 'whale']
  adjectives = ['jazzy', 'fuzzy', 'dizzy', 'zippy', 'jumbo', 'small', 'tiny', 'big', 'huge', 'tall', 'crazy', 'silly', 'cold', 'fast', 'strong', 'major', 'joyous', 'angry', 'lazy', 'clean', 'fancy', 'long', 'plain', 'clever', 'easy', 'odd', 'rich', 'vast', 'famous', 'shy', 'mushy', 'fierce', 'tender', 'brave', 'calm', 'eager', 'nice', 'proud', 'happy', 'gentle', 'jolly', 'kind', 'lively', 'deep', 'flat', 'steep', 'massive', 'petite', 'faint', 'loud', 'quiet', 'modern', 'old', 'rapid', 'quick', 'young', 'swift', 'hot', 'icy', 'melted', 'salty', 'yummy', 'sweet', 'broken', 'bumpy', 'cool', 'dry', 'full', 'sparse', 'able', 'acidic', 'busy', 'cheap', 'elite', 'cheif', 'bent', 'brainy', 'bright', 'burly', 'exotic', 'caring', 'callous', 'earthy', 'dark', 'cuddly', 'curved', 'cute', 'dusty', 'even', 'jaded', 'fair', 'famous', 'flashy', 'foamy', 'giddy', 'glossy', 'groovy', 'lean', 'kindly', 'macho', 'lucky', 'lush', 'marked', 'mellow', 'misty', 'narrow', 'noisy', 'nutty', 'nifty', 'plain', 'polite', 'rare', 'rebel', 'rough', 'royal', 'rustic', 'scary', 'secret', 'silent', 'silky', 'tacky', 'tan', 'tense', 'tired', 'soft', 'spooky', 'stiff', 'super', 'superb', 'swanky', 'ultra', 'unruly', 'upbeat', 'useful', 'wacky', 'wicked', 'witty', 'wry', 'zany', 'zesty', 'swag', 'wary', 'versed', 'unique']
  creature   = creatures.sample.capitalize
  adjective  = adjectives.sample.capitalize
  poster     = creature.downcase + Random.rand(1..8).to_s

end
