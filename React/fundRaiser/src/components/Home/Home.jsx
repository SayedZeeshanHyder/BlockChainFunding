import React, { useState, useRef } from 'react';
import './Home.css';
import logo from "/src/images/Glorious Purpose.svg";
import charityImg from "/src/images/charity-img.png";
import disasterImg from '/src/images/diasater-img.png';
import medicalImg from '/src/images/medical-img.png';
import crowdImg from '/src/images/crowdf-img.png';
import ellipse from '/src/images/Ellipse 2.svg';
import useResponsive from '/src/useResponsive';
import { Link, NavLink } from 'react-router-dom';
import LoginModal from './LoginModal';

function Home() {
  const { width } = useResponsive();
  const [isModalOpen, setModalOpen] = useState(false);
  const aboutRef = useRef(null); // Step 2: Create a ref for the "About Us" section

  const openModal = () => {
    setModalOpen(true);
  };

  const closeModal = () => {
    setModalOpen(false);
  };

  const scrollToAbout = () => {
    aboutRef.current.scrollIntoView({ behavior: 'smooth' }); // Step 3: Scroll to the "About Us" section
  };

  return (
    <div className="App">
      <header className={`top ${isModalOpen ? 'content-blur' : ''}`}>
        <nav className="nav">
          <img src={logo} alt="Logo" className="logo" />
          <button className="btn" id="abt" onClick={scrollToAbout}>About us</button> {/* Update onClick handler */}
          <button className="btn" onClick={openModal}>Login</button>
        </nav>
      </header>

      <div className={`space ${isModalOpen ? 'content-blur' : ''}`}></div>

      <div className={`ani-cont ${isModalOpen ? 'content-blur' : ''}`}>
        <DisplayBox title="Charity" imgSrc={charityImg} width={width} />
        <DisplayBox title="Disaster Relief" imgSrc={disasterImg} width={width} />
        <DisplayBox title="Medical funds" imgSrc={medicalImg} width={width} />
        <DisplayBox title="Crowd Funding" imgSrc={crowdImg} width={width} />
      </div>

      <div className={`quote ${isModalOpen ? 'content-blur' : ''}`}>
        “LETS SUPPORT THOSE IN NEED”
      </div>
      
      <div className={`ellipse ${isModalOpen ? 'content-blur' : ''}`}>
        <img src={ellipse} alt="Ellipse" />
        <AboutSection ref={aboutRef} /> {/* Pass the ref to the AboutSection component */}
      </div>

      <LoginModal show={isModalOpen} onClose={closeModal} />
    </div>
  );
}

function DisplayBox({ title, imgSrc, width }) {
  return (
    <div className="dis-box">
      <div className="g-text">{title}</div>
      <div className="img-box">
        <img src={imgSrc} alt={title} />
      </div>
    </div>
  );
}

const AboutSection = React.forwardRef((props, ref) => { // Update AboutSection to accept a ref
  return (
    <div className="about-section" ref={ref}>
      <h2>About Us</h2>
      <p id="about">
        Welcome to our fundraiser website!<br />
        We are dedicated to making a positive impact in the community by creating a platform to raise funds for various causes and initiatives. Our team consists of passionate individuals who believe in the power of collective action to bring about change.
      </p>
      <div className='flex-col w-[80vw] justify-evenly'>
        <ProfileSection name="Zeeshan Hyder" gmail="zhyder133@gmail.com" role="App Developer" github="https://github.com/SayedZeeshanHyder" />
        <ProfileSection name="Yash Shellar" gmail="ydshelar04@gmail.com" role="Backend Developer" github="https://github.com/YashShelar04"/>
        <ProfileSection name="Ashmit Shelke" gmail="ashmit.shelke3135@gmail.com" role="Frontend Developer" github="https://github.com/Ashmit-1729"/>
      </div>
    </div>
  );
});

function ProfileSection({name, linked_in, twitter, gmail, github,role,image}) {
  let default_image = "/src/images/Person.svg";
  if(image!=null)
    default_image = image;
  return (
    // <div className='flex'>
    //   <div className='flex-col'>
    //     <div className='font-bold text-lg'>
    //       {name}
    //     </div>
    //     <div className='flex items-center'>
    //       <img src="/src/images/linked_in.svg" className='mr-5 w-[20px] h-[20px]' alt="" />
    //       <a href={linked_in}>Linked in</a>
    //     </div>
    //     <div className='flex items-center '>
    //       <img src="/src/images/twitter.svg" className='mr-5 w-[20px] h-[20px]' alt="" />
    //       <a href={twitter}>Twitter</a>
    //     </div>
    //     <div className='flex items-center'>
    //       <img src="/src/images/gmail.svg" className='mr-5 w-[20px] h-[20px]' alt="" />
    //       <a href={gmail}>Gmail</a>
    //     </div>
    //     <div className='flex items-center'>
    //       <img src="/src/images/git_icon.svg" className='mr-5 w-[20px] h-[20px]' alt="" />
    //       <a href={github}>Github</a>
    //     </div>
    //   </div>
    // </div>

    <div className='flex bg-green-200 rounded-lg w-[70%]  items-center mb-5 shadow-md'>
        <div className='ml-5 mr-10 mt-5 mb-5'>
          <img src={default_image} className="w-28 h-28 rounded-full" alt="" />
        </div>
        <div className='flex-col'>
          <div className='text-2xl font-bold'>
            {name}
          </div>
          <div>
            {role}
          </div>

          <div>
            {gmail}
          </div>

          <div className='flex w-[100%] justify-evenly'>
              <Link to={github}>
              <img src="/src/images/git_icon.svg" alt=""/>
              </Link>
              <img src="/src/images/linked_in.svg" alt="" />
              <img src="/src/images/twitter.svg" alt="" />
          </div>
        </div>
    </div>

  );
}

export default Home;
