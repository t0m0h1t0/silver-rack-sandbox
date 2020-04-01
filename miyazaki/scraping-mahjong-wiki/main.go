package main

import (
	"github.com/PuerkitoBio/goquery"
  "encoding/json"
  "fmt"
  "os"
  "io/ioutil"
  "strings"
)

const (
  URL = "https://ja.wikipedia.org/wiki/%E9%BA%BB%E9%9B%80%E3%81%AE%E5%BD%B9%E4%B8%80%E8%A6%A7"
)

var (
  SpanIdToIntYaku = map[int]int {
    1: 1,
    2: 2,
    3: 3,
    4: 6,
    5: 13,
  }
)

type MahjongHand struct {
  Name string `json:"name"`
  Kana string `json:"kana"`
  Yaku int `json:"yaku"`
  Description string `json:"description"`
  Restriction string `json:"restriction"`
}

type MahjongHands struct {
  Hands []MahjongHand `json:"hands"`
}

func fetchWiki() MahjongHands{
	resp := MahjongHands {
    Hands: []MahjongHand{},
  }
	doc, err := goquery.NewDocument(URL)
	if err != nil {
		panic(err)
	}

  selection := doc.Find("table.wikitable")
  selection.Each(func(index int, s *goquery.Selection) {
    yaku, ok := SpanIdToIntYaku[index]
    if !ok {
      return
    }
    tr := s.Find("tr")
    for i := 0; i < len(tr.Nodes); i++ {
      td := tr.Find("td")
      name := extractStrElement(td)
      td = td.Next()
      kana := extractStrElement(td)
      td = td.Next().Next()
      restriction := extractStrElement(td)
      td = td.Next()
      description := extractStrElement(td)
      hand := MahjongHand {
        Name: name,
        Kana: kana,
        Yaku: yaku,
        Restriction: restriction,
        Description: description,
      }
      resp.Hands = append(resp.Hands, hand)
      tr = tr.Next()
    }
  })
  return resp
}

func removeBlank(s string) string  {
  res := strings.Replace(s, " ", "", -1)
  return res
}
func removeNewLine(s string) string{
  res := strings.Replace(s, "\n", "", -1)
  return res
}

func extractStrElement(s *goquery.Selection) string {
  res := removeBlank(s.First().Text())
  res = removeNewLine(res)
  return res
}

func writeJson(src MahjongHands) {
  fileName := "mahjong_yaku.json"
  handsJson, err := json.MarshalIndent(src, "", " ")
  if err != nil {
    panic(err)
  }
  writeFile(fileName, handsJson)
}

func writeFile(fileName string, bytes []byte) {
    ioutil.WriteFile(fileName, bytes, os.ModePerm)
}

func handler() {
  resp := fetchWiki()
  fmt.Println(resp)
  writeJson(resp)
}

func main() {
  handler()
}
