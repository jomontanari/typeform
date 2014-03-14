# encoding: UTF-8

module TypeForm

  EXPECTED_MAPPED_OBJECTS = [
    {
      :name_and_company=>"Jo from Here",
      :telephone=>"03455 3333",
      :colour=>"Yellow",
      :weather=>{:sun=>true, :cloud=>true, :rain=>true, :snow=>true}
    },
    {
      :name_and_company=>"Joseph from A Place",
      :telephone=>"03456 3333",
      :colour=>"Pink",
      :weather=>{:sun=>false, :cloud=>false, :rain=>true, :snow=>true}
    },
    {
      :name_and_company=>"Jane from Nowhere",
      :telephone=>"02222 3333",
      :colour=>"Green",
      :weather=>{:sun=>true, :cloud=>false, :rain=>true, :snow=>true}
    },
    {
      :name_and_company=>"John from Somewhere",
      :telephone=>"01111 3333",
      :colour=>"Blue",
      :weather=>{:sun=>true, :cloud=>false, :rain=>false, :snow=>false}
    }
  ]

  RESPONSE_DATA = {
    http_status: 200,
    stats: {
      responses: {
        showing: 4,
        total: 12,
        completed: 4
      }
    },
    questions: [
      {
        id: "textfield_1011",
        question: "What's your name and company name?"
      },
      {
        id: "textfield_1012",
        question: "What's your phone number?"
      },
      {
        id: "list_555_choice",
        question: "What's your favourite colour?"
      },
      {
        id: "list_555_other",
        question: "What's your favourite colour?"
      },
      {
        id: "list_612_choice_743",
        question: "What weather do you like?"
      },
      {
        id: "list_612_choice_744",
        question: "What weather do you like?"
      },
      {
        id: "list_612_choice_745",
        question: "What weather do you like?"
      },
      {
        id: "list_612_choice_746",
        question: "What weather do you like?"
      }
    ],
responses: [
{
  id: "13",
  completed: "1",
  token: "84c31888e5a674fcfe69eedbe321f799",
  locked: "0",
  metadata: {
    browser: "default",
    platform: "other",
    date_land: "2014-03-03 10:20:12",
    date_submit: "2014-03-03 10:21:22",
    user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36",
    referer: "",
    ip: "154389845951bae066682def9d9c0dc5f2f2f4ca"
    },
    hidden: [ ],
    answers: {
      textfield_1011: "Jo from Here",
      textfield_1012: "03455 3333",
      list_555_choice: "Yellow",
      list_555_other: "",
      list_612_choice_743: "Sunshine",
      list_612_choice_744: "Clouds",
      list_612_choice_745: "Rain",
      list_612_choice_746: "Snow"
    }
    },
    {
      id: "14",
      completed: "1",
      token: "5256b2f5ea09c24813d7fe8fd857a412",
      locked: "0",
      metadata: {
        browser: "default",
        platform: "other",
        date_land: "2014-03-03 10:29:52",
        date_submit: "2014-03-03 10:30:10",
        user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36",
        referer: "",
        ip: "154389845951bae066682def9d9c0dc5f2f2f4ca"
      },
      hidden: [ ],
      answers: {
        textfield_1011: "Joseph from A Place",
        textfield_1012: "03456 3333",
        list_555_choice: "",
        list_555_other: "Pink",
        list_612_choice_743: "",
        list_612_choice_744: "",
        list_612_choice_745: "Rain",
        list_612_choice_746: "Snow"
      }
    },
    {
      id: "15",
      completed: "1",
      token: "56ca4c37ee9d52eb87037ab40c7f71e5",
      locked: "0",
      metadata: {
        browser: "default",
        platform: "other",
        date_land: "2014-03-03 11:52:57",
        date_submit: "2014-03-03 11:54:53",
        user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36",
        referer: "",
        ip: "154389845951bae066682def9d9c0dc5f2f2f4ca"
      },
      hidden: [ ],
      answers: {
        textfield_1011: "Jane from Nowhere",
        textfield_1012: "02222 3333",
        list_555_choice: "",
        list_555_other: "Green",
        list_612_choice_743: "Sunshine",
        list_612_choice_744: "",
        list_612_choice_745: "Rain",
        list_612_choice_746: "Snow"
      }
    },
    {
      id: "17",
      completed: "1",
      token: "d51cf86351513f98e75ae7e95b845b21",
      locked: "0",
      metadata: {
        browser: "default",
        platform: "other",
        date_land: "2014-03-04 09:37:29",
        date_submit: "2014-03-05 09:21:23",
        user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36",
        referer: "",
        ip: "154389845951bae066682def9d9c0dc5f2f2f4ca"
      },
      hidden: [ ],
      answers: {
        textfield_1011: "John from Somewhere",
        textfield_1012: "01111 3333",
        list_555_choice: "Blue",
        list_555_other: "",
        list_612_choice_743: "Sunshine",
        list_612_choice_744: "",
        list_612_choice_745: "",
        list_612_choice_746: ""
      }
    }
    ]   
  }
end