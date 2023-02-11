class RouteProduct
  def initialize(product)
    @product = product
    @model = Destination
  end

  def call
    product.update(destination_id: filtered_destination.id) if filtered_destination
  end

  private

    attr_reader :product, :query, :model

    def filtered_destination
      run_reference_query
      run_category_query
      run_max_price_query
      sort_result
    end

    def sort_result
      query.sort_by {|d| [d.categories.count, d.references.count] }
           .reverse
           .first
    end

    def run_reference_query
      @query = model.where('destinations.references REGEXP ?', product.reference)
    end

    def run_category_query
      @query = if (result = query.where('destinations.categories REGEXP ?', product.category)).count > 0
                  result
                else
                  query.or(model.where('destinations.categories REGEXP ?', product.category))
                end
    end

    def run_max_price_query
      @query = if (result = query.where('destinations.maximum_price > ?', product.price)).count > 0
                  result
                elsif (result = query.where('destinations.maximum_price IS NULL')).count > 0
                  result
                elsif (result = query.or(model.where('destinations.maximum_price > ?', product.price))).count > 0
                  result
                else
                  query
                end
    end
end
