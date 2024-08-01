import React, { useState } from 'react';
import { Editor } from '@tinymce/tinymce-react';
import parse from 'html-react-parser';
import NavBar from '../NavBar/NavBar';

const BlogCreationPage = () => {
    const [content, setContent] = useState('');
    const [parsedContent, setParsedContent] = useState('');

    const handleEditorChange = (content, editor) => {
        setContent(content);
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        setParsedContent(content);
        console.log(parse(parsedContent).toString());
        setContent('');
    };

    return (
        
        <div>
             <div className="w-72 mt-2 ml-2">
                <img src="/src/images/Glorious Purpose.svg" alt="" />
            </div>
            <NavBar username="USERNAME" />
            <div className='w-[70%] absolute top-16 left-72 right-10'>
            <form onSubmit={handleSubmit}>
                <Editor
                    apiKey="e0g3k6uxpmlw4rwoydbmdgx6nkocat4ryynr7699g2zpdugl"
                    initialValue="<p>Share your experience of this campaign...</p>"
                    init={{
                        height: 500,
                        menubar: 'file edit insert format tools table help',
                        plugins: [
                            'advlist autolink lists link image charmap print preview anchor',
                            'searchreplace visualblocks code fullscreen',
                            'insertdatetime media table paste code help wordcount',
                            'fontsize'
                        ],
                        toolbar:
                            'undo redo | formatselect | fontselect | fontsizeselect | bold italic backcolor | ' +
                            'alignleft aligncenter alignright alignjustify | ' +
                            'bullist numlist outdent indent | removeformat | help'
                    }}
                    onEditorChange={handleEditorChange}
                />
                <button type="submit" className='m-10 p-3 bg-green-500 text-white rounded-lg font-bold'>Submit</button>
            </form>
            </div>
            {/* <div>
                <h2>Blog Preview</h2>
                {parse(parsedContent)}
            </div> */}
        </div>
    );
};

export default BlogCreationPage;
