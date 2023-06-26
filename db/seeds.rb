# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: "fa@f.com", password: "123456")

Customer.create( name: "りく", email: "riku@example.com", password: "123456", foot_size: "27.4", foot_width: 1, foot_type: 1, gender: 1, is_deleted: false )
Customer.create( name: "はる", email: "haru@example.com", password: "123456", foot_size: "23.4", foot_width: 2, foot_type: 3, gender: 2, is_deleted: false )
Customer.create( name: "さく", email: "saku@example.com", password: "123456", foot_size: "26.5", foot_width: 3, foot_type: 2, gender: 1, is_deleted: false )

Shoe.create( name: 'インスタポンプ フューリー OG', body: '靴のサイズはちょうどいい。足首の前のところが当たるため、長時間履くなら長めの靴下の方がいい。', shoe_size: '24', price: '10000', match_rate: '90', tag_name: 'リーボック、スニーカー、黒', customer_id: 2 )
Shoe.create( name: 'カイリー７', body: 'とても履き心地が良い。プレー中も痛いところがなく、とてもいい。', shoe_size: '28.5', price: '16000', match_rate: '85', tag_name: 'バスケ、ナイキ、カイリー、ブラック、ハイカット', customer_id: 1 )
Shoe.create( name: 'エアフォース1', body: 'いい感じだが、もう少し小さくてもよかったかもしれない。', shoe_size: '27.5', price: '12000', match_rate: '65', tag_name: 'ナイキ、白、スニーカー、エアフォース', customer_id: 3 )
Shoe.create( name: 'フラットシューズ000', body: 'とてもいい。長時間履いていても疲れない。', shoe_size: '24', price: '19000', match_rate: '90', tag_name: 'マーガレット・ハウエル アイデア、マーガレット・ハウエル、ヒール、4.5cm、黒', customer_id: 2 )
Shoe.create( name: 'ユニーク', body: '小指の付け根と薬指の第２関節があったてしまい、とても痛い。もう少し大きくてもよかったかも。', shoe_size: '27', price: '15000', match_rate: '40', tag_name: 'KEEN、ブラック、サンダル', customer_id: 3 )
Shoe.create( name: 'ゼラポート ツー サンダル', body: '履きやすいし、とても気にっているが、もうワンサイズ大きくてもよかった気がする。', shoe_size: '28', price: '11000', match_rate: '60', tag_name: 'keen、サンダル、ブラック', customer_id: 1 )
Shoe.create( name: 'インスタポンプ フューリー OG', body: 'お気に入りすぎて、色違いを購入。サイズは前回と同じ', shoe_size: '24', price: '10000', match_rate: '90', tag_name: 'リーボック、スニーカー、ネイビー', customer_id: 2 )