<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta charset="utf-8">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
    <meta name="format-detection" content="telephone=no" />

    <title>INSTAGRAM GRAPH DEMO</title>

    <style>
        /* html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,time,figure,article,nav,header,footer,hgroup,video,audio,aside,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,font,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td {
            margin: 0;
            padding: 0;
            border: 0;
            font-weight: inherit;
            font-style: inherit;
            vertical-align: baseline;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            text-align:center;
        } */
       
        ol,ul {list-style: none;}
        table {border-collapse: separate;border-spacing: 0;}
        caption,th,td {text-align: left;font-weight: normal;}
        figure,article,header,footer,nav,hgroup,video,audio,aside,main {display: block;}
        #instagram { margin:0;text-align:center;  overflow: hidden;width: 100%;}
        .instagram_item {display:inline-block;width:20%;padding-right: 1px; padding-bottom: 1px; margin-left:10px;}
        .instagram_item > a {display: block; width: 100%;padding-top: 100%;position: relative;background: no-repeat center center;background-size: cover;}
        .instagram_item > a:before {content: '';position: absolute;left: 0;right: 0;top: 0;bottom: 0;background: #000000;background: rgba(0, 0, 0, .8);background: -webkit-radial-gradient(center, ellipse cover, rgba(0, 0, 0, .5) 0%, rgba(0, 0, 0, .8) 100%);background: -webkit-radial-gradient(center, ellipse, rgba(0, 0, 0, .5) 0%, rgba(0, 0, 0, .8) 100%);background: radial-gradient(ellipse at center, rgba(0, 0, 0, .5) 0%, rgba(0, 0, 0, .8) 100%);z-index: 1;opacity: 0;-webkit-transition: opacity .55s cubic-bezier(.215, .61, .355, 1);transition: opacity .55s cubic-bezier(.215, .61, .355, 1);}
        .instagram_item p {width: 100%;padding: 19px 57px;position: absolute;left: 0;top: 50%;font-size: 16px;font-weight: 400;text-align: left;color: #fff;transform: translateY(-50%);z-index: 2;opacity: 0;-webkit-transition: opacity .55s cubic-bezier(.215,.61,.355,1);transition: opacity .55s cubic-bezier(.215,.61,.355,1);}
        .instagram_item > a:hover:before {opacity: 1;}
        .instagram_item > a:hover p {opacity: 1;}
    </style>
</head>
<body class=body>

    <div id="instagram"></div>
    <script>

        var token = "IGQVJWcC1DclhVQ0JMU0xWSzVGQzVhTE1tLTdnMHp0bURNSkRtWmpOUTVaMUdJeFNJUzZAidkh4WHZAnMVFkQ0pLOG5jaHpOTnlJSm80QUxCM2ZAVWkI3SXhIV3MxRjIyem9Va3dlSjhmTncySC13alRPRwZDZD";

        /*
            발급된 토큰은 장기 실행 액세스 토큰으로 60일간 사용이 가능합니다.
            https://developers.facebook.com/docs/instagram-basic-display-api/guides/long-lived-access-tokens

            발급된 토큰은 만료일(60일)이내에 refresh_access_token혹은, 페이스북 개발자 센터내의 토큰 재발급을 통해 연장을 해주어야합니다.
            https://developers.facebook.com/docs/instagram-basic-display-api/reference/refresh_access_token
        */

        $.ajax({
            type: "GET",
            dataType: "jsonp",
            cache: false,
            url: "https://graph.instagram.com/me/media?access_token=" + token + "&fields=id,caption,media_type,media_url,thumbnail_url,permalink",
            success: function(response) {
                console.log(response);
                if (response.data != undefined && response.data.length > 0) {
                    for(i = 0; i < 4; i++){
                        if(response.data[i]){
                            var item = response.data[i];
                            var image_url = "";
                            var post = "";

                            if(item.media_type === "VIDEO"){
                                image_url = item.thumbnail_url;
                            }else{
                                image_url = item.media_url;
                            }

                            post += '<div class="instagram_item instagram_item'+i+'">';
                                post += '<a href="'+ item.permalink +'" target="_blank" rel="noopener noreferrer" style="background-image: url(' + image_url + ');">';
                                    post += '<p>'+ item.caption +'</p>';
                                post += '</a>';
                            post += '</div>';

                            $('#instagram').append(post);
                        }else{
                            // if no curent item
                            show_fallback('#insta-item-'+i)
                        }
                    }
                }else{
                    // if api error
                    show_fallback('.instagram-item')
                }
            },
            error :function(){
                // if http error
                show_fallback('.instagram-item')
            }

        });

        function show_fallback(el){
            $(el).addClass('loaded fallback');
        }

    </script>
</body>
</html>