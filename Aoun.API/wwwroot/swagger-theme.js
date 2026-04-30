window.addEventListener('load', function() {
    // نستخدم setInterval لضمان تحميل عناصر Swagger بالكامل قبل الزرع
    var checkExist = setInterval(function() {
        var infoSection = document.querySelector('.swagger-ui .info');
        if (infoSection && !document.getElementById('theme-toggle')) {
            clearInterval(checkExist);
            
            var btn = document.createElement('button');
            btn.id = 'theme-toggle';
            btn.title = 'Toggle Dark/Light Mode';
            
            var isDark = localStorage.getItem('swagger-dark') === 'true';
            btn.innerHTML = isDark ? '☀️' : '🌙';
            if (isDark) document.body.classList.add('dark-theme');

            btn.addEventListener('click', function() {
                document.body.classList.toggle('dark-theme');
                var darkEnabled = document.body.classList.contains('dark-theme');
                localStorage.setItem('swagger-dark', darkEnabled);
                btn.innerHTML = darkEnabled ? '☀️' : '🌙';
            });
            
            // إضافة الزر داخل منطقة الـ Info
            infoSection.appendChild(btn);
        }
    }, 100); // يفحص كل 100 ملي ثانية
});
window.addEventListener('load', function() {

    // ----------------------------------------------------
    // 2. Professional Payment Success/Fail Modal
    // ----------------------------------------------------
    var urlParams = new URLSearchParams(window.location.search);
    var successParam = urlParams.get('success');

    // إذا كان الرابط يحتوي على كلمة success (سواء true أو false)
    if (successParam !== null) {
        // تحويل القيمة لنص صغير للتأكد من قراءتها بشكل صحيح دائماً
        var isSuccess = String(successParam).trim().toLowerCase() === 'true';

        // إنشاء الخلفية الضبابية (Overlay)
        var overlay = document.createElement('div');
        overlay.style.cssText = 'position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.6);z-index:10000;display:flex;align-items:center;justify-content:center;font-family:"Segoe UI",Tahoma,sans-serif;backdrop-filter:blur(5px);';

        // إنشاء مربع الرسالة (Modal)
        var modal = document.createElement('div');
        modal.style.cssText = 'background:#fff;padding:40px 30px;border-radius:16px;text-align:center;width:90%;max-width:400px;box-shadow:0 15px 30px rgba(0,0,0,0.3);animation:popIn 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);';

        // إنشاء الأيقونة (صح أو خطأ)
        var icon = document.createElement('div');
        icon.style.cssText = 'width:80px;height:80px;border-radius:50%;margin:0 auto 20px;display:flex;align-items:center;justify-content:center;font-size:40px;box-shadow:0 4px 10px rgba(0,0,0,0.1);';
        
        if (isSuccess) {
            icon.style.background = '#e8f5e9';
            icon.style.color = '#4caf50';
            icon.innerHTML = '✔️';
        } else {
            icon.style.background = '#ffebee';
            icon.style.color = '#f44336';
            icon.innerHTML = '❌';
        }

        // إنشاء العنوان
        var title = document.createElement('h2');
        title.style.cssText = 'margin:0 0 10px;color:#333;font-size:24px;font-weight:bold;';
        title.innerText = isSuccess ? 'تم الدفع بنجاح!' : 'فشلت عملية الدفع';

        // إنشاء النص التفصيلي
        var text = document.createElement('p');
        text.style.cssText = 'margin:0 0 30px;color:#666;font-size:16px;line-height:1.6;';
        if (isSuccess) {
            var orderId = urlParams.get('order') || 'N/A';
            text.innerHTML = 'شكراً لك! تم تسجيل تبرعك في منصة <b>"عون"</b> بنجاح.<br><span style="font-size:13px;color:#999;">رقم العملية: ' + orderId + '</span>';
        } else {
            text.innerText = 'عذراً، تم رفض البطاقة أو حدث خطأ أثناء المعالجة من قبل بوابة الدفع. يرجى المحاولة ببطاقة أخرى.';
        }

        // إنشاء زر العودة
        var closeBtn = document.createElement('button');
        closeBtn.style.cssText = 'background:' + (isSuccess ? '#4caf50' : '#f44336') + ';color:#fff;border:none;padding:14px 24px;border-radius:30px;font-size:16px;cursor:pointer;font-weight:bold;width:100%;transition:transform 0.2s,box-shadow 0.2s;';
        closeBtn.innerText = 'العودة للمنصة';
        closeBtn.onmouseover = function() { this.style.transform = 'translateY(-2px)'; this.style.boxShadow = '0 6px 12px rgba(0,0,0,0.15)'; };
        closeBtn.onmouseout = function() { this.style.transform = 'translateY(0)'; this.style.boxShadow = 'none'; };
        
        closeBtn.onclick = function() {
            document.body.removeChild(overlay);
            // تنظيف الرابط من بيانات Paymob ليعود نظيفاً
            window.history.replaceState({}, document.title, window.location.pathname);
        };

        // إضافة العناصر لبعضها
        modal.appendChild(icon);
        modal.appendChild(title);
        modal.appendChild(text);
        modal.appendChild(closeBtn);
        overlay.appendChild(modal);
        document.body.appendChild(overlay);

        // إضافة الأنيميشن للصفحة
        var style = document.createElement('style');
        style.innerHTML = '@keyframes popIn { 0% { transform: scale(0.5); opacity: 0; } 100% { transform: scale(1); opacity: 1; } }';
        document.head.appendChild(style);
    }
});


window.addEventListener('load', function() {
    var checkExist = setInterval(function() {
        var infoSection = document.querySelector('.swagger-ui .info');
        if (infoSection && !document.getElementById('theme-toggle')) {
            clearInterval(checkExist);

            var btn = document.createElement('button');
            btn.id = 'theme-toggle';
            btn.title = 'Toggle Dark/Light Mode';

            // التحقق من الوضع الداكن عند تحميل الصفحة
            var isDark = localStorage.getItem('swagger-dark') === 'true';
            btn.innerHTML = isDark ? '☀️' : '🌙';  // تعيين الأيقونة بناءً على الوضع

            if (isDark) document.body.classList.add('dark-theme');

            btn.addEventListener('click', function() {
                // التبديل بين الوضعين
                document.body.classList.toggle('dark-theme');
                var darkEnabled = document.body.classList.contains('dark-theme');
                localStorage.setItem('swagger-dark', darkEnabled);

                // تغيير الأيقونة بناءً على الوضع
                if (darkEnabled) {
                    btn.innerHTML = '☀️';  // الشمس في الوضع الداكن
                } else {
                    btn.innerHTML = '🌙';  // القمر في الوضع الفاتح
                }
            });

            // إضافة الزر داخل منطقة الـ Info
            infoSection.appendChild(btn);
        }
    }, 100); // يفحص كل 100 ملي ثانية
});