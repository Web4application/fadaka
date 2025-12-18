#include "oatpp-curl/RequestExecutor.hpp"
#include "oatpp/web/client/ApiClient.hpp"
#include "oatpp/core/macro/codegen.hpp"
#include "oatpp/core/macro/component.hpp"

#include <iostream>

class PriceApi : public oatpp::web::client::ApiClient {
#include OATPP_CODEGEN_BEGIN(ApiClient) ///< Begin codegen

  API_CLIENT_INIT(PriceApi)

  API_CALL("GET", "/price/fdak", getFadakPrice)  // Replace with your real API path

#include OATPP_CODEGEN_END(ApiClient) ///< End codegen
};

int main() {
  oatpp::base::Environment::init();

  oatpp::network::ClientConnectionProviderShared provider =
    oatpp::network::client::SimpleTLSConnectionProvider::createShared("api.mockservice.com", 443); // HTTPS

  auto executor = oatpp::web::client::RequestExecutor::createShared(provider);
  auto client = PriceApi::createShared(executor);

  auto response = client->getFadakPrice();
  auto body = response->readBodyToString();

  std::cout << "💰 FDAK Price Response:\n" << *body << std::endl;

  oatpp::base::Environment::destroy();
  return 0;
}
