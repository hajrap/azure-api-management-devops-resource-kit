import "./libs/shim/core.js";
import "./libs/shim/urijs.js";
import http from 'k6/http';
import {  group,check } from 'k6';
import { jUnit, textSummary } from 'https://jslib.k6.io/k6-summary/0.0.1/index.js';

export let options = {
  scenarios: {
    constant_request_rate: {
      executor: 'constant-arrival-rate',
      rate: 1,//rate limit 
      timeUnit: '30s', //renewal-period
      duration: '30s',
      preAllocatedVUs: 100, // how large the initial pool of VUs would be
      maxVUs: 200, // if the preAllocatedVUs are not enough, we can initialize more
    },
  },
};
export let postman_options = { maxRedirects: 4 };
const Request = Symbol.for("request");
postman[Symbol.for("initial")]({
  postman_options,
  environment: {
    APIM_URL: "https://apim-corenonprod01-integration-00.azure-api.net",
    APIM_SUBSCRIPTION_KEY: "ac884be3755b435d9b04840897cf2b3d",
    APIM_SUBSCRIPTION_KEY_ELASTIC_SEARCH: "ac884be3755b435d9b04840897cf2b3d",
    APIM_SUBSCRIPTION_KEY_ABN_LOOKUP: "ac884be3755b435d9b04840897cf2b3d",
    APIM_SUBSCRIPTION_KEY_PROPERTY_LOOKUP: "ac884be3755b435d9b04840897cf2b3d"
  }
});

export default function (data) {
    group("billing-api", function() {
      postman[Request]({
        name: "AccountBalance",
        id: "fc814f5e-0654-44dc-a4dd-4c7fc5b200e8",
        method: "GET",
        address: "{{APIM_URL}}/billing/v1/AccountBalance/00",
        headers: {
          "Ocp-Apim-Subscription-Key": "{{APIM_SUBSCRIPTION_KEY}}",
          "Ocp-Apim-Trace": "True",
          ApplicationID: "{{ApplicationID}}",
          TransactionContextID: "{{guid}}",
          UserID: "{{UserID}}",
          Version: "1.0",
          "Content-Type": "application/json"
        },
        post(response) {
          pm.test(
            "Billing API Account Balance result response is ok",
            function() {
              pm.response.to.have.status(200);
            }
          );
          pm.test(
            "Billing API Account Balance result response is Rate limit is exceeded. Try again in 27 seconds",
            function() {
              pm.response.to.have.status(429);
            }
          );
        }
      });
    });
  }
  export function handleSummary(data) {
    //let filepath = `./${__ENV.TESTRESULT_FILENAME}-result.xml`;
      return {
          'stdout': textSummary(data, { indent: ' ', enableColors: true}), 
          './loadtest-results.xml': jUnit(data), 
      }
  }
