// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

//EDIT ONLY THESE VALUES
var bagCloudfrontUrl = 'REPLACE-WITH-CFURL' //bagCloudfrontUrl
var bagCognitoClientID = 'REPLACE-WITH-COGNITO' //bagCognitoClientID
var bagCognitoDomainName = 'REPLACE-WITH-COGDOMAIN' //bagCognitoDomainName
var bagCognitoPoolsId = 'REPLACE-WITH-POOLS-ID' //bagCognitoPoolsId
var API_URL = 'REPLACE-WITH-APIURL'; //bagControlApiUrl

const query_string = "?bagtagname=REPLACE-WITH-IDTAGNAME&bagtagvalue=REPLACE-WITH-IDTAGVALUE"
var tagName = 'REPLACE-WITH-IDTAGNAME'
var tagValue = 'REPLACE-WITH-IDTAGVALUE'
var stackname = 'REPLACE-WITH-STACKNAME'
//EDIT ONLY THESE VALUES

var aws_auth_config = {
  "aws_user_pools_id": bagCognitoPoolsId,
  "aws_user_pools_web_client_id": bagCognitoClientID,
  "oauth": {
      "domain": bagCognitoDomainName,
      "scope": [
          "openid",
          "aws.cognito.signin.user.admin"
      ],
      "redirectSignIn": bagCloudfrontUrl + '/signed_in.html',
      "redirectSignOut": bagCloudfrontUrl + '/logout.html',
      "responseType": "code"
  },
  "federationTarget": "COGNITO_USER_POOLS",
  "aws_cognito_username_attributes": ["EMAIL"],
  "aws_cognito_signup_attributes": [
      "EMAIL"
  ],
  "aws_cognito_mfa_configuration": "OFF",
  "aws_cognito_mfa_types": [
      "SMS"
  ],
  "aws_cognito_password_protection_settings": {
      "passwordPolicyMinLength": 8,
      "passwordPolicyCharacters": []
  },
  "aws_cognito_verification_mechanisms": [
      "EMAIL"
  ]
};
