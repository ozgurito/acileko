import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();  // Kullanıcı mesajı
  final List<Map<String, String>> _messages = [];  // Mesajlar listesi
  bool _isLoading = false;  // Yükleme durumu

  // Chatbot yanıtlarını ekle
  void _sendMessage(String userMessage) async {
    setState(() {
      _messages.add({'sender': 'user', 'message': userMessage});  // Kullanıcı mesajını ekle
      _isLoading = true;
    });

    _controller.clear();  // Mesaj kutusunu temizle

    try {
      String botResponse = getBotResponse(userMessage);
      setState(() {
        _messages.add({'sender': 'bot', 'message': botResponse});  // Bot mesajını ekle
      });
    } catch (error) {
      setState(() {
        _messages.add({'sender': 'bot', 'message': 'Bir hata oluştu, lütfen tekrar deneyin.'});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Bot yanıtlarını manuel olarak oluşturduk
  String getBotResponse(String message) {
    if (message.toLowerCase().contains("ne zaman deprem oldu")) {
      return "Son deprem bilgileri Kandilli Rasathanesi'nden alınmıştır. Bugün saat 14:32'de İzmir'in Narlıdere ilçesinde 4.3 büyüklüğünde bir deprem meydana gelmiştir. Bu büyüklükteki bir deprem yer yüzeyinde önemli değişikliklere neden olmasa da yer altındaki yapılar üzerinde bazı sarsıntılara yol açabilir. Her zaman tetikte olun ve güvenli alanları belirleyin.";
    } else if (message.toLowerCase().contains("ne yapmalıyız")) {
      return "Deprem sırasında yapılması gerekenler, yaşamınızı korumak açısından kritik öneme sahiptir. Deprem başladığında:\n\n1. Sakin olun, panik yapmayın.\n2. Yüksek yerlerden ve camlardan uzaklaşın. Güvenli bir alana sığının.\n3. Sakın panikle hareket etmeyin. Eğer dışarıdaysanız, binalardan uzak durun.\n4. Başınızı koruyun. Deprem bittikten sonra güvenli bir alanı terk edin.";
    } else if (message.toLowerCase().contains("acileko nedir")) {
      return "AcilEko, gelişmiş bir deprem tahmin ve kriz yönetimi sistemidir. Bu uygulama, deprem anında en güvenli yolları belirlemenizi sağlar, en hızlı tahliye rotalarını sunar ve yerel yetkililer tarafından gönderilen gerçek zamanlı deprem verilerini kullanıcıya iletir. AcilEko, aynı zamanda binaların acil çıkış planlarını içerir ve kriz anlarında sizi yönlendirir.";
    } else if (message.toLowerCase().contains("deprem sigortası yaptırmalı mıyım")) {
      return "Evet, deprem sigortası, deprem nedeniyle oluşabilecek büyük maddi kayıplara karşı bir güvence sağlar. Türkiye, deprem riski yüksek bir bölge olduğundan, evinizi veya iş yerinizi sigortalatmak, meydana gelebilecek bir felakette maddi açıdan sizi rahatlatacaktır. Zorunlu deprem sigortası (DASK) kapsamında olmasa dahi, özel sigorta şirketleri tarafından sağlanan teminatları inceleyebilirsiniz.";
    } else if (message.toLowerCase().contains("deprem sonrası ne yapmalıyım")) {
      return "Deprem sonrasında ilk adım, sağlığınızın kontrolünü sağlamaktır. Güvenli bir alanda olduğunuzu doğruladıktan sonra:\n\n1. Elektrik ve gaz vanalarını kapatın.\n2. Bina hasarını kontrol edin. Çatlaklar ve devrilen eşyalar varsa, güvenli bir şekilde binayı terk edin.\n3. İletişim hatları yoğun olabileceğinden acil yardım numaralarına başvurun.\n4. Sizi ve sevdiklerinizi güvende tutun.";
    } else {
      return "Bilmiyorum, ancak size yardımcı olabilecek başka bir konuda yardımcı olabilirim. Lütfen sorunuzu tekrar edin.";
    }
  }

  // Menüdeki soruları seçme
  void _handleMenuSelection(String selection) {
    _sendMessage(selection);  // Seçilen soruya yanıtı gönder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AcilEko Chatbot'),
        centerTitle: true,
        backgroundColor: Color(0xFF5A55CA),  // Başlık rengi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Menü seçenekleri
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () => _handleMenuSelection('Son Deprem Ne Zaman Oldu?'),
                    child: Text('Son Deprem Ne Zaman Oldu?'),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleMenuSelection('Deprem Anında Ne Yapmalıyız?'),
                    child: Text('Deprem Anında Ne Yapmalıyız?'),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleMenuSelection('AcilEko Nedir?'),
                    child: Text('AcilEko Nedir?'),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleMenuSelection('Deprem Sigortası Yaptırmalı Mıyım?'),
                    child: Text('Deprem Sigortası Yaptırmalı Mıyım?'),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleMenuSelection('Deprem Sonrası Ne Yapmalıyım?'),
                    child: Text('Deprem Sonrası Ne Yapmalıyım?'),
                  ),
                ],
              ),
            ),
            // Mesajlar listesi
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  var message = _messages[index];
                  bool isUserMessage = message['sender'] == 'user';

                  return Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        message['message']!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isLoading) CircularProgressIndicator(),  // Yükleme göstergesi
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Sorunuzu yazın...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),  // Kullanıcı mesajını gönder
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
