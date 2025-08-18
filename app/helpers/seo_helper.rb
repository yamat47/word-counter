module SeoHelper
  def meta_title
    'Word Counter - Free Online Word, Character & Paragraph Counter'
  end

  def meta_description
    'Count words, characters, and paragraphs instantly with our free online word counter. ' \
      'Clean, simple, and works in real-time as you type. No ads, no registration required.'
  end

  def meta_keywords
    'word counter, character counter, paragraph counter, text counter, word count tool, ' \
      'free word counter, online word counter, real-time word count, text analysis, writing tool'
  end

  def meta_author
    'yamat47'
  end

  def og_image_url
    "#{request.protocol}#{request.host_with_port}/icon.png"
  end

  def canonical_url
    root_url
  end

  def structured_data
    {
      '@context': 'https://schema.org',
      '@type': 'WebApplication',
      name: 'Word Counter',
      description: meta_description,
      url: canonical_url,
      applicationCategory: 'UtilityApplication',
      operatingSystem: 'Web Browser',
      offers: structured_data_offer,
      creator: structured_data_creator,
      datePublished: '2025-01-01',
      inLanguage: 'en-US'
    }.to_json
  end

  private

  def structured_data_offer
    {
      '@type': 'Offer',
      price: '0',
      priceCurrency: 'USD'
    }
  end

  def structured_data_creator
    {
      '@type': 'Person',
      name: meta_author
    }
  end
end
