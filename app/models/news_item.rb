# Gemfile
# gem 'stemmify'

require 'stemmify'
require 'nmatrix'

# Article class
class Article
  attr_accessor :title, :body, :tokens

  def initialize(title, body)
    @title = title
    @body = body
    @tokens = tokenize_and_stem("#{title} #{body}")
  end

  private

  def tokenize_and_stem(text)
    text.downcase.scan(/\b[\w']+\b/).map(&:stem)
  end
end

# TF-IDF vectorizer
class TfIdf
  attr_reader :vocabulary, :idf

  def initialize(documents)
    all_tokens = documents.flat_map(&:tokens)
    @vocabulary = all_tokens.uniq
    @idf = compute_idf(documents)
  end

  def compute_idf(docs)
    n_docs = docs.size.to_f
    vocabulary.each_with_object({}) do |term, h|
      doc_count = docs.count { |d| d.tokens.include?(term) }
      h[term] = Math.log((n_docs + 1) / (doc_count + 1)) + 1
    end
  end

  def vector(doc)
    NMatrix[
      vocabulary.map { |term|
        tf = doc.tokens.count(term).to_f / doc.tokens.size
        tf * idf[term]
      }
    ]
  end
end

# Cosine similarity helper
def cosine_similarity(vec_a, vec_b)
  dot = (vec_a * vec_b).sum
  norm_a = Math.sqrt((vec_a * vec_a).sum)
  norm_b = Math.sqrt((vec_b * vec_b).sum)
  return 0 if norm_a == 0 || norm_b == 0
  dot / (norm_a * norm_b)
end

# Hierarchical clustering
def hierarchical_clustering(vectors, threshold: 0.3)
  clusters = vectors.map.with_index { |v, i| [i] } # start each article as its own cluster

  loop do
    max_sim = 0
    merge_pair = nil

    clusters.combination(2).each do |c1, c2|
      # compute average similarity between clusters
      sim = c1.product(c2).map { |i, j| cosine_similarity(vectors[i], vectors[j]) }.sum
      sim /= (c1.size * c2.size)
      if sim > max_sim
        max_sim = sim
        merge_pair = [c1, c2]
      end
    end

    break if max_sim < threshold
    # merge clusters
    clusters.delete(merge_pair[0])
    clusters.delete(merge_pair[1])
    clusters << (merge_pair[0] + merge_pair[1])
  end

  clusters
end


