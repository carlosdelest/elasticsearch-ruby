# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

module Elasticsearch
  module API
    module SQL
      module Actions
        # Returns the current status and available results for an async SQL search or stored synchronous SQL search
        #
        # @option arguments [String] :id The async search ID
        # @option arguments [String] :delimiter Separator for CSV results
        # @option arguments [String] :format Short version of the Accept header, e.g. json, yaml
        # @option arguments [Time] :keep_alive Retention period for the search and its results
        # @option arguments [Time] :wait_for_completion_timeout Duration to wait for complete results
        # @option arguments [Hash] :headers Custom HTTP headers
        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/master/get-async-sql-search-api.html
        #
        def get_async(arguments = {})
          raise ArgumentError, "Required argument 'id' missing" unless arguments[:id]

          headers = arguments.delete(:headers) || {}

          arguments = arguments.clone

          _id = arguments.delete(:id)

          method = Elasticsearch::API::HTTP_GET
          path   = "_sql/async/#{Utils.__listify(_id)}"
          params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

          body = nil
          perform_request(method, path, params, body, headers).body
        end

        # Register this action with its valid params when the module is loaded.
        #
        # @since 6.2.0
        ParamsRegistry.register(:get_async, [
          :delimiter,
          :format,
          :keep_alive,
          :wait_for_completion_timeout
        ].freeze)
      end
    end
  end
end