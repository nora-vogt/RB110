require 'pry'
# Term frequency - inverse document frequency:
# A measure of how important a term is to a document in a collection of documents
# (the importance increases proportionally to the term frequency in the document,
# but decreases with the frequency of the word across documents)

def tfidf(term, document, documents)
  # tf = tf(term, document)
  # idf = idf(term, documents)
  # p "tf is #{tf}, idf is #{idf}"
  # tf * idf
  tf(term, document) * idf(term, documents)
  #p "term frequency for #{term} is #{tf} in document #{document}."
end

# Term frequency (simple version):
# the number of times a term occurs in a document

def tf(term, document)
  document.split(/[\s,.-]/).count { |word| word.downcase == term }
end

# Inverse document frequency:
# measure of how much information the word provides,
# based on the number of documents in which it occurs
# (the rarer it is, the more information it provides)

def idf(term, documents)
  number_of_documents = documents.length
  number_of_documents_with_term = documents.count { |d| tf(term, d) > 0 }
  return 0 if number_of_documents_with_term.zero?
  Math.log(number_of_documents.to_f / number_of_documents_with_term.to_f)
end

# Very simple example

document1 = "Schrödinger's cat is a thought experiment often featured in discussions of the interpretation of quantum mechanics. The Austrian physicist Erwin Schrödinger devised " +
"it in 1935 as an argument against the Copenhagen interpretation of quantum mechanics, which states that an object in a physical system can simultaneously exist in all possible configurations, " +
"a state called quantum superposition, and only observing the system forces the object into just one of those possible states. Schrödinger disagreed with this interpretation. In particular, " +
"quantum superposition could not work with larger objects. As an illustration, he presented a scenario with a cat in a sealed box, whose fate was linked to a subatomic event that may or may not occur. " +
"In a quantum superposed state of the subatomic particles, the cat would be both alive and dead, until someone opened the box and observed it."

document2 = "The domestic cat is a small, furry, carnivorous mammal. The term cat can, however, also refer to wild cats, which include animals like lions, tigers and leopards. " +
"Cats are claimed to have a lower social IQ than dogs but can solve more difficult cognitive problems and have a longer-term memory. International Cat Day is celebrated on August 8. " +
"Famous cats include Schrödinger's cat as well as Pudding and Butterscotch, which occur in some of the Launch School assignments."

document3 = "One of the core values that sets Launch School apart from some other coding schools out there is our emphasis on Mastery-based Learning. If the key to becoming a competent and confident Software Engineer " +
"is deep understanding of first principles, then the key to acquiring that understanding is through Mastery-based Learning. The core of Mastery-based Learning is replacing time with mastery. There's no graduation, " +
"but a continual learning journey of micro-improvements. At Launch School, we're not trying to catch a wave or take advantage of a surge in demand. Instead, we're trying to focus on things that'll be useful to you for decades to come, " +
"such as a systematic problem-solving approach or learning how to deconstruct a programming language or building sound mental representations of how web application work. Everything we're trying to do at " +
"Launch School is with an eye towards sustainable studying habits and building skills for a long-term career."

documents = [document1, document2, document3]

# The higher the tf-idf score of a term for a document, the more informative
# it is for that document.
# E.g. when someone searches for the term 'cat' in your document collection,
# you want to return document1 and document2, but not document3.
# For the term 'quantum mechanics', on the other hand, you only want to return document1.

# expected outputs:
puts tfidf("cat", document1, documents) # ~ 1.2 ; current 0.0
puts tfidf("cat", document2, documents) # ~ 1.6 ; current 0.0
puts tfidf("cat", document3, documents) # 0

puts tfidf("quantum", document1, documents) # ~ 5.5
puts tfidf("quantum", document2, documents) # 0
puts tfidf("quantum", document3, documents) # 0

puts tfidf("mastery", document1, documents) # 0
puts tfidf("mastery", document2, documents) # 0
puts tfidf("mastery", document3, documents) # ~ 4.4

puts tfidf("some", document1, documents) # 0
puts tfidf("some", document2, documents) # ~ 0.4 ; current 0.0
puts tfidf("some", document3, documents) # ~ 0.4 ; current 0.0


=begin
The unexpected results are due to line 31, `Math.log(number_of_documents / number_of_documents_with_term)`. This code passes the result of Integer division to `Math.log` as an argument, and the return value of `number_of_documents / number_of_documents_with_term` will return an integer value, without the remainder. This truncating causes unexpected results, causing `Math.log` to return `0.0` for any term that appears in more than one document.

To fix this, we need to pass in the Float equivalent of `number_of_documents` and `number_of_documents_with_term`, which will pass a Float to `Math.log` as an argument, giving us the desired output.

# Further Exploration:
When we remove document1 from the collection of documents and get the tfidf of "quantum", we see `NaN` (Not a Number) output. Within the `idf` method definition, `number_of_documents` is now `2`, and `"quantum"` doesn't appear in either document, so `number_of_documents_with_term` is now `0`. When we calculate `Math.log(2.0 / 0.0)`, we get `Infinity` - because dividing by zero when performing Float division returns `Infinity`.

# To fix this, we want to add a return statement at line 31, returning `0` from the `idf` method if `number_of_documents` is zero.


# idf is returning an incorrect value from Math.log - returning 0.0 when a term appears in more than one document (Math.log(3/2))

when given "cat",
  - appears in document 1 and 2
  - documet 1 tfidf is 0.0 instead of 1.2 (too low)
  - document 2 tdidf is 0.0 instead of 1.6 (too low)
  - document 3 is correct (cat does not appear, tfidf is 0)

when given "quantum",
  - only appears in document 1
  - document 1 is correct
  - document 2 is correct
  - document 3 is correct

when given "mastery"
  - only appears in document 3
  - document 1 is correct
  - document 2 is correct
  - document 3 is correct

when given "some",
  - appears in documents 2 and 3
  - document 1 is correct
  - document 2 is incorrect at 0.0 instead of 0.4 (too low)
  - document 3 is incorrect at 0.0 instead of 0.4 (too low)

when a term appears in multiple documents, we are getting 0.0 for the documents it appears in, instead of the correct value.

when a term only appears in one document, we get the correct value.

=end