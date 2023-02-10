class RouteProduct
  def initialize(product)
    @product = product
  end

  def call
    product.update(destination_id: filtered_destination.id) if filtered_destination
  end

  private

    attr_reader :product

    def filtered_destination
      query = Destination.where('destinations.references REGEXP ?', product.reference)

      query = if (result = query.where('destinations.categories REGEXP ?', product.category)).count > 0
        result
      else
        query.or(Destination.where('destinations.categories REGEXP ?', product.category))
      end

      query = if (result = query.where('destinations.maximum_price > ?', product.price)).count > 0
         result
       elsif (result = query.where('destinations.maximum_price IS NULL')).count > 0
        result
      elsif (result = query.or(Destination.where('destinations.maximum_price > ?', product.price))).count > 0
        result
      else
        query
      end

      query = query.sort_by {|d| [d.categories.count, d.references.count] }
                   .reverse
                   .first
    end
end
