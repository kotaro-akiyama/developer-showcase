const products = [
  {
    name: "グリーンバランス スムージー",
    description: "小松菜・ケール・大麦若葉を独自比率でブレンド。忙しい朝でも手軽に野菜習慣を。",
    price: "¥3,240",
    badge: "人気 No.1",
  },
  {
    name: "発酵サプリ 麹プロテイン",
    description: "発酵大豆と玄米タンパクを発酵麹で仕上げた植物性プロテイン。吸収効率にこだわりました。",
    price: "¥4,980",
    badge: "限定",
  },
  {
    name: "ハーブリカバリー ティー",
    description: "有機カモミールとルイボス、国産柚子をブレンド。リラックスタイムのお供に。",
    price: "¥2,180",
    badge: "新商品",
  },
];

const testimonials = [
  {
    name: "東京都 40代 女性",
    quote:
      "朝のスムージーが習慣化しました。子どもと一緒に飲める味で、家族全員の体調が安定しています。",
  },
  {
    name: "大阪府 30代 男性",
    quote:
      "麹プロテインは胃にもたれず、運動後でも飲みやすい。肌の調子も良くなりました。",
  },
  {
    name: "福岡県 50代 女性",
    quote:
      "夜のハーブティーで睡眠の質が上がった気がします。自然な香りで癒されます。",
  },
];

const renderProducts = () => {
  const container = document.getElementById("product-grid");
  container.innerHTML = products
    .map(
      (product) => `
        <article class="product-card">
          <span class="product-card__badge">${product.badge}</span>
          <h3>${product.name}</h3>
          <p>${product.description}</p>
          <div class="product-card__price">${product.price}</div>
          <button class="hero__cta" data-product="${product.name}">詳しく見る</button>
        </article>
      `
    )
    .join("");
};

const renderTestimonials = () => {
  const container = document.getElementById("testimonials");
  container.innerHTML = testimonials
    .map(
      (item) => `
        <figure class="testimonial-card">
          <blockquote class="testimonial-card__quote">“${item.quote}”</blockquote>
          <figcaption>${item.name}</figcaption>
        </figure>
      `
    )
    .join("");
};

const setupSubscribeForm = () => {
  const form = document.getElementById("subscribe-form");
  const message = document.getElementById("subscribe-message");

  form.addEventListener("submit", (event) => {
    event.preventDefault();
    const email = new FormData(form).get("email");

    message.textContent = `${email} で登録を受け付けました。ありがとうございます！`;
    form.reset();
  });
};

const setupProductButtons = () => {
  const container = document.getElementById("product-grid");
  container.addEventListener("click", (event) => {
    const target = event.target;
    if (!(target instanceof HTMLButtonElement)) return;

    const productName = target.dataset.product ?? "";
    alert(`${productName} の詳細は近日公開予定です。お楽しみに！`);
  });
};

const updateYear = () => {
  const yearEl = document.getElementById("year");
  yearEl.textContent = String(new Date().getFullYear());
};

document.addEventListener("DOMContentLoaded", () => {
  renderProducts();
  renderTestimonials();
  setupSubscribeForm();
  setupProductButtons();
  updateYear();
});
